ActiveAdmin.register PlantCategory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :plant_category, :created_at, :updated_at, plant_subcategory_ids: []

  filter :plant_category
  filter :updated_at
  filter :created_at

  #
  # or
  #
  # permit_params do
  #   permitted = [:plant_category]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
