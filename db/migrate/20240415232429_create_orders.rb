class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.boolean :paid
      t.references :status, null: false, foreign_key: true
      t.string :shipping_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
