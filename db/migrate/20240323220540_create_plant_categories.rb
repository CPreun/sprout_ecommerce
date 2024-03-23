class CreatePlantCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_categories do |t|
      t.string :plant_category

      t.timestamps
    end
  end
end
