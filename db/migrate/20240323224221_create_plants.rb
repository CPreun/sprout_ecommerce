class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.string :scraper_id
      t.string :name
      t.string :sku
      t.string :latin_name
      t.string :family_name
      t.integer :maturity_min
      t.integer :maturity_max
      t.integer :zone_min
      t.integer :zone_max
      t.text :description
      t.boolean :drought_tolerant
      t.boolean :salt_tolerant
      t.boolean :poisonous
      t.boolean :pet_friendly
      t.boolean :medicinal
      t.boolean :edible
      t.boolean :fruits
      t.boolean :thorns
      t.string :growth
      t.string :care_level
      t.string :image_link
      t.string :info_link
      t.references :plant_subcategory, null: false, foreign_key: true
      t.references :seed_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
