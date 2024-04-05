ActiveAdmin.register PlantCategory do
  menu parent: "Plants"

  permit_params :plant_category, :created_at, :updated_at, :image, plant_subcategory_ids: []

  filter :plant_category
  filter :updated_at
  filter :created_at

  index do
    selectable_column
    column :id
    column :plant_category
    column :image do |plant_category|
      plant_category.image.present? ? image_tag(plant_category.image, size: '100x100') : content_tag(:span, "No Image")
    end
    column :updated_at
    actions
  end

  show do
    attributes_table do
      row :plant_category
      row :image do |plant_category|
        plant_category.image.present? ? image_tag(plant_category.image, size: '100x100') : content_tag(:span, "No Image")
      end
      row :updated_at
      row :created_at
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :plant_category
      f.input :image, as: :file, hint: f.object.image.present? ? image_tag(f.object.image, size: '100x100') : content_tag(:span, "No Image")
    end
    f.actions
  end
end