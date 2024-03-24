full_sun_entry = SunlightAmount.find_or_create_by(amount: 'Full sun')
puts full_sun_entry.inspect
partial_sun_entry = SunlightAmount.find_or_create_by(amount: 'Partial sun')
puts partial_sun_entry.inspect
partial_shade_entry = SunlightAmount.find_or_create_by(amount: 'Partial shade')
puts partial_shade_entry.inspect
full_shade_entry = SunlightAmount.find_or_create_by(amount: 'Full shade')
puts full_shade_entry.inspect

require 'csv'

csv_file = Rails.root.join('db', 'west_coast_seeds.csv')
data = File.read(csv_file)
plants = CSV.parse(data, headers: true)

# populate sunlight table first

plants.each do |plant|
    plant_category = PlantCategory.find_or_initialize_by(plant_category: plant['category'].strip.capitalize)
    # plant_category.save
    puts plant_category.inspect

    plant_subcategory = PlantSubcategory.find_or_initialize_by(plant_subcategory: plant['subcategory'].strip.capitalize, plant_category_id: plant_category.id)
    # plant_subcategory.save
    puts plant_subcategory.inspect

    new_plant = Plant.find_or_initialize_by(scraper_id: plant['scraper_id']) do |p|
        p.name = plant['name']
        p.sku = plant['sku'].scan(/SKU: (.*)/).flatten.first
        # p.latin_name = plant['latin_name']
        # p.family_name = plant['family_name']
        # p.maturity_min = plant['maturity_min']
        # p.maturity_max = plant['maturity_max']
        # p.zone_min = plant['zone_min']
        # pp.zone_max = plant['zone_max']
        p.description = plant['description']
        # p.care_level = plant['care_level']
        p.image_link = plant['image_link']
        p.info_link = plant['info_link']
        p.plant_subcategory_id = plant_subcategory.id
        # p.seed_type_id = seed_type.id

        # images
    end

    puts new_plant.inspect

    price_hash = JSON.parse(plant['prices'])
    price_hash.each do |price_data|
        price_string = price_data['prices']
        weight = price_string.scan(/(\d+[a-z]+)/).flatten.first&.strip
        seed_amount = price_string.scan(/(\d+) seeds/).flatten.first&.strip&.to_i
        price = price_string.scan(/\$([\d,]+(?:\.\d+)?)/).flatten.first&.gsub(',', '')&.to_d
        parsed_price_data = Price.new(weight: weight, quantity: seed_amount, price: price, plant_id: new_plant.id)
        puts parsed_price_data.inspect
        puts parsed_price_data.price
    end

    facts_hash = JSON.parse(plant['facts'])
    # puts facts_hash

    facts_hash.each do |fact|
        fact_string = fact['facts']

        if fact_string.include?('Exposure')
            if fact_string.include?('Full sun')
                puts "Full sun"
            end

            if fact_string.include?('Partial sun')
                puts "Partial sun"
            end

            if fact_string.include?('Partial shade')
                puts "Partial shade"
            end            

            if fact_string.include?('Full shade')
                puts "Full shade"
            end
        end
        
        if fact_string.include?('Matures')
            mature_string = fact_string.scan(/\d+/).flatten.first&.strip&.split('-')
            mature_min = mature_string.first&.to_i
            mature_max = mature_string.last&.to_i
            puts "#{mature_min} - #{mature_max} days"
        end

        if fact_string.include?('Seed type')
            seed_type = fact_string.scan(/Seed type (.*) \?/).flatten.first&.strip
            puts seed_type
        end
    end

    about_hash = JSON.parse(plant['all_about'])
    puts about_hash

    about_hash.each do |about|
        about_string = about['all_about']

        if about_string.include?('Latin')
            latin_name = about_string.scan(/Latin\n(.*)\n?/).flatten.first&.strip
            puts latin_name
        end

        if about_string.include?('Family')
            family_name = about_string.scan(/Family:(.*)/).flatten.first&.strip&.capitalize
            puts family_name
        end

        if about_string.include?('Difficulty')
            difficulty_level = about_string.scan(/Difficulty\n(.*)/).flatten.first&.strip&.capitalize
            puts difficulty_level
        end
    end

    puts "====================="
end