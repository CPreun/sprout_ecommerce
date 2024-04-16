class CreateOrderItems < ActiveRecord::Migration[7.1]
  def change
    create_table :order_items do |t|
      t.references :plant, null: false, foreign_key: true
      t.integer :quantity
      t.string :weight
      t.decimal :unit_price
      t.decimal :gst_rate
      t.decimal :pst_rate
      t.decimal :hst_rate
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
