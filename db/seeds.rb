=begin
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

plants.each do |plant|
    plant_category = PlantCategory.find_or_initialize_by(plant_category: plant['category'].strip.capitalize)
    plant_category.save
    puts plant_category.inspect

    plant_subcategory = PlantSubcategory.find_or_initialize_by(plant_subcategory: plant['subcategory'].strip.capitalize, plant_category_id: plant_category.id)
    plant_subcategory.save
    puts plant_subcategory.inspect

    new_plant = Plant.find_or_initialize_by(scraper_id: plant[0].to_s) do |p|
        p.name = plant['name']
        p.sku = plant['sku'].scan(/SKU: (.*)/).flatten.first
        # p.zone_min = plant['zone_min']
        # pp.zone_max = plant['zone_max']
        p.description = plant['description']
        p.image_link = plant['image_link']
        p.info_link = plant['info_link']
        p.plant_subcategory_id = plant_subcategory.id
    end
    new_plant.save

    price_hash = JSON.parse(plant['prices'])
    price_hash.each do |price_data|
        price_string = price_data['prices']
        weight = price_string.scan(/(\d+[a-z]+)/).flatten.first&.strip
        seed_amount = price_string.scan(/(\d+) seeds/).flatten.first&.strip&.to_i
        price = price_string.scan(/\$([\d,]+(?:\.\d+)?)/).flatten.first&.gsub(',', '')&.to_d
        new_price = Price.find_or_initialize_by(price: price, plant_id: new_plant.id)
        new_price.weight = weight
        new_price.quantity = seed_amount
        new_price.save
        puts new_price.inspect
        puts new_price.price
    end

    facts_hash = JSON.parse(plant['facts'])
    facts_hash.each do |fact|
        fact_string = fact['facts']

        if fact_string.include?('Exposure')
            if fact_string.include?('Full sun')
                # association = new_plant.sunlight_amounts.find_or_initialize_by(id: full_sun_entry.id)
                unless new_plant.sunlight_amounts.exists?(full_sun_entry.id)
                    association = new_plant.sunlight_amounts << full_sun_entry
                    puts association.inspect
                end
            end

            if fact_string.include?('Partial sun')
                # association = new_plant.sunlight_amounts.find_or_initialize_by(plant_id: new_plant.id, sunlight_amount_id: partial_sun_entry.id)
                # puts association.inspect
                unless new_plant.sunlight_amounts.exists?(partial_sun_entry.id)
                    association = new_plant.sunlight_amounts << partial_sun_entry
                    puts association.inspect
                end
            end

            if fact_string.include?('Partial shade')
                # association = new_plant.sunlight_amounts.find_or_initialize_by(plant_id: new_plant.id, sunlight_amount_id: partial_shade_entry.id)
                # puts association.inspect
                unless new_plant.sunlight_amounts.exists?(partial_shade_entry.id)
                    association = new_plant.sunlight_amounts << partial_shade_entry
                    puts association.inspect
                end
            end            

            if fact_string.include?('Full shade')
                # association = new_plant.sunlight_amounts.find_or_initialize_by(plant_id: new_plant.id, sunlight_amount_id: full_shade_entry.id)
                # puts association.inspect
                unless new_plant.sunlight_amounts.exists?(full_shade_entry.id)
                    association = new_plant.sunlight_amounts << full_shade_entry
                    puts association.inspect
                end
            end
        end
        
        if fact_string.include?('Matures')
            mature_string = fact_string.scan(/\d+/).flatten.first&.strip&.split('-')
            unless mature_string.nil?
                mature_min = mature_string.first&.to_i
                mature_max = mature_string.last&.to_i
                new_plant.maturity_min = mature_min
                new_plant.maturity_max = mature_max                
            end
        end

        if fact_string.include?('Seed type')
            seed_type = fact_string.scan(/Seed type (.*) \?/).flatten.first&.strip

            new_seed_type = SeedType.find_or_initialize_by(seed_type: seed_type)
            new_seed_type.save
            puts new_seed_type.inspect
            new_plant.seed_type_id = new_seed_type.id
        end
    end

    about_hash = JSON.parse(plant['all_about'])
    about_hash.each do |about|
        about_string = about['all_about']

        if about_string.include?('Latin')
            latin_name = about_string.scan(/Latin\n(.*)\n?/).flatten.first&.strip
            new_plant.latin_name = latin_name
        end

        if about_string.include?('Family')
            family_name = about_string.scan(/Family:(.*)/).flatten.first&.strip&.capitalize
            new_plant.family_name = family_name
        end

        if about_string.include?('Difficulty')
            difficulty_level = about_string.scan(/Difficulty\n(.*)/).flatten.first&.strip&.capitalize
            new_plant.care_level = difficulty_level
        end
    end

    new_plant.save
    puts new_plant.valid?
    # puts new_plant.errors.full_messages
    
    unless new_plant.image.attached?
        require 'open-uri'

        image_url = 'https://' + new_plant.image_link
        downloaded_image = URI.open(image_url)
        new_plant.image.attach(io: downloaded_image, filename: "#{new_plant.name.downcase.gsub(' ', '_')}.jpg")
    end

    new_plant.save
    puts new_plant.valid?
    # puts new_plant.errors.full_messages

    puts "====================="
    sleep(2000)
end

Province.create(province: "Alberta", code: "AB", gst: 0.05)
Province.create(province: "British Columbia", code: "BC", gst: 0.05, pst: 0.07)
Province.create(province: "Manitoba", code: "MB", gst: 0.05, pst: 0.07)
Province.create(province: "New Brunswick", code: "NB", hst: 0.15)
Province.create(province: "Newfoundland and Labrador", code: "NL", hst: 0.15)
Province.create(province: "Northwest Territories", code: "NT", gst: 0.05)
Province.create(province: "Nova Scotia", code: "NS", hst: 0.15)
Province.create(province: "Nunavut", code: "NU", gst: 0.05)
Province.create(province: "Ontario", code: "ON", hst: 0.13)
Province.create(province: "Prince Edward Island", code: "PE", gst: 0.05, pst: 0.10)
Province.create(province: "Quebec", code: "QC", gst: 0.05, pst: 0.09975)
Province.create(province: "Saskatchewan", code: "SK", gst: 0.05, pst: 0.06)
Province.create(province: "Yukon", code: "YT", gst: 0.05)
=end