ActiveAdmin.register Plant do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :sku, :latin_name, :family_name, :maturity_min, :maturity_max, :zone_min, :zone_max, :description, :drought_tolerant, :salt_tolerant, :poisonous, :pet_friendly, :medicinal, :edible, :fruits, :thorns, :growth, :care_level, :info_link, :image, 
                plant_subcategory_ids: [:plant_subcategory, plant_category_ids: []]

  filter :name
  filter :latin_name
  filter :family_name
  # filter :plant_category_id, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }
  filter :plant_subcategory_id, as: :select, collection: PlantSubcategory.all.map { |subcategory| [subcategory.plant_subcategory, subcategory.id] }
  filter :created_at
  filter :updated_at

  # or
  #
  # permit_params do
  #   permitted = [:scraper_id, :name, :sku, :latin_name, :family_name, :maturity_min, :maturity_max, :zone_min, :zone_max, :description, :drought_tolerant, :salt_tolerant, :poisonous, :pet_friendly, :medicinal, :edible, :fruits, :thorns, :growth, :care_level, :image_link, :info_link, :plant_subcategory_id, :seed_type_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  # remove_filter :image_attachment, :image_blob, :seed_type, :plant_sunlight_amounts, :sunlight_amounts, :prices, :scraper_id, :sku, :zone_min, :zone_max, :maturity_min, :maturity_max, :drought_tolerant, :salt_tolerant, :poisonous, :pet_friendly, :medicinal, :edible, :fruits, :thorns, :growth, :care_level, :description, :image_link, :info_link
end
