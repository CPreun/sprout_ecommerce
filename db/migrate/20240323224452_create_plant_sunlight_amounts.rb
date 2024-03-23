class CreatePlantSunlightAmounts < ActiveRecord::Migration[7.1]
  def change
    create_table :plant_sunlight_amounts do |t|
      t.references :plant, null: false, foreign_key: true
      t.references :sunlight_amount, null: false, foreign_key: true

      t.timestamps
    end
  end
end
