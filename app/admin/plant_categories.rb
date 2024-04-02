ActiveAdmin.register PlantCategory do
  menu parent: "Plants"

  permit_params :plant_category, :created_at, :updated_at, plant_subcategory_ids: []

  filter :plant_category
  filter :updated_at
  filter :created_at

end
