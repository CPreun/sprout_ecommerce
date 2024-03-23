class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.decimal :price
      t.string :weight
      t.integer :quantity
      t.references :plant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
