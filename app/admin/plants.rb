ActiveAdmin.register Plant do
  permit_params :name, :sku, :latin_name, :family_name, :maturity_min, :maturity_max, :zone_min, :zone_max, :description, 
                :drought_tolerant, :salt_tolerant, :poisonous, :pet_friendly, :medicinal, :edible, :fruits, :thorns, :growth, 
                :care_level, :info_link, :image, :plant_subcategory_id, :seed_type_id,
                :prices_attributes => [:id, :price, :weight, :quantity, :sale, :_destroy],
                :category_ids => [:id, :plant_category, :_destroy],
                :sunlight_amount_ids => [:id, :sunlight_amount, :_destroy]
                
  filter :name
  filter :latin_name
  filter :family_name
  # filter :plant_category_id, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }
  filter :plant_subcategory_id, as: :select, collection: PlantSubcategory.all.order(:plant_category_id).map { |subcategory| ["#{subcategory.plant_category.plant_category} - #{subcategory.plant_subcategory}", subcategory.id]}
  filter :created_at
  filter :updated_at
  
  # remove_filter :image_attachment, :image_blob, :seed_type, :plant_sunlight_amounts, :sunlight_amounts, :prices, :scraper_id, :sku, :zone_min, :zone_max, :maturity_min, :maturity_max, :drought_tolerant, :salt_tolerant, :poisonous, :pet_friendly, :medicinal, :edible, :fruits, :thorns, :growth, :care_level, :description, :image_link, :info_link

  controller do
    def scoped_collection
      Plant.includes(plant_subcategory: :plant_category, seed_type: :plants, sunlight_amounts: :plant_sunlight_amounts, prices: :plant)
    end
  end

  index do
    selectable_column
    column :name
    column :latin_name
    column :sku
    column "Plant Category" do |plant|
      plant.plant_subcategory.plant_category.plant_category
    end
    column "Plant Subcategory" do |plant|
      plant.plant_subcategory.plant_subcategory
    end
    column "Image" do |plant|
      plant.image.present? ? image_tag(plant.image, size: '100x100') : content_tag(:span, "No Image")
    end
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row "Scraper ID" do |plant|
        plant.scraper_id
      end
      row :name
      row :latin_name
      row :family_name
      row :sku
      row "Plant Category" do |plant|
        plant.plant_subcategory.plant_category.plant_category
      end
      row "Plant Subcategory" do |plant|
        plant.plant_subcategory.plant_subcategory
      end
      row "Prices" do |plant|
        table do
          thead do
            if plant.prices.present?
              tr do
                th "Price"
                th "Weight"
                th "Quantity"
                th "Sale"
              end
            end
          end
          plant.prices.each do |price|
            tr do
              td price.price
              td price.weight
              td price.quantity
              td price.sale
            end
          end
        end
      end
      row "Seed Type" do |plant|
        plant.seed_type.present? ? plant.seed_type.seed_type : "N/A"
      end
      row :maturity_min
      row :maturity_max
      row :zone_min
      row :zone_max
      row :description
      row :drought_tolerant
      row :salt_tolerant
      row :poisonous
      row :pet_friendly
      row :medicinal
      row :edible
      row :fruits
      row :thorns
      row :growth
      row :care_level
      row :info_link
      row "Image Link" do |plant|
        plant.image_link
      end
      row "Image" do |plant|
        plant.image.present? ? image_tag(plant.image, size: '100x100') : content_tag(:span, "No Image")
      end
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :name
      f.input :sku
      # f.input :plant_category, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }, input_html: { id: 'plant_category_select' }
      f.input :plant_subcategory, as: :select, collection: PlantSubcategory.all.order(:plant_category_id).map { |subcategory| ["#{subcategory.plant_category.plant_category} - #{subcategory.plant_subcategory}", subcategory.id]}, input_html: { id: 'plant_subcategory_select' }, prompt: "Select a category..."
      f.inputs "Prices" do
        f.has_many :prices, heading: false, allow_destroy: true do |price|
          price.input :price
          price.input :weight
          price.input :quantity
          price.input :sale
        end
      end
      f.input :latin_name
      f.input :family_name
      f.input :maturity_min
      f.input :maturity_max
      f.input :zone_min
      f.input :zone_max
      f.input :description
      f.input :drought_tolerant
      f.input :salt_tolerant
      f.input :poisonous
      f.input :pet_friendly
      f.input :medicinal
      f.input :edible
      f.input :fruits
      f.input :thorns
      f.input :growth
      f.input :care_level
      f.input :info_link
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '100x100') : content_tag(:span, "Upload image")
    end
    f.actions
  end

end
