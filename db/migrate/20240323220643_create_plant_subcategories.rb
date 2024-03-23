class CreatePlantSubcategories < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_subcategories do |t|
      t.string :plant_subcategory
      t.references :plant_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
