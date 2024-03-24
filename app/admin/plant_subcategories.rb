ActiveAdmin.register PlantSubcategory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :plant_subcategory, :created_at, :updated_at, plant_category_ids: []

  filter :plant_subcategory
  filter :plant_category_id, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }
  filter :updated_at
  filter :created_at
  
  # or
  #
  # permit_params do
  #   permitted = [:plant_subcategory, :plant_category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
