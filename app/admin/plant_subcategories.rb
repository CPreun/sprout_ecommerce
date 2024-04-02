ActiveAdmin.register PlantSubcategory do
  menu parent: "Plants"

  permit_params :plant_subcategory, :created_at, :updated_at, :plant_category_id, plant_category_ids: []

  filter :plant_subcategory
  filter :plant_category_id, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }
  filter :updated_at
  filter :created_at

  controller do
    def scoped_collection
      PlantSubcategory.includes(:plant_category)
    end
  end
  
  index do
    selectable_column
    column :id
    column :plant_subcategory
    column "Plant Category" do |subcategory|
      subcategory.plant_category.plant_category
    end
    column :updated_at
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :plant_category, as: :select, collection: PlantCategory.all.map { |category| [category.plant_category, category.id] }, prompt: "Select a category..."
      f.input :plant_subcategory
    end
    f.actions
  end
end
