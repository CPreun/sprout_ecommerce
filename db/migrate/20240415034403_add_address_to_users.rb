class AddAddressToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone, :string
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :postal_code, :string
    add_reference :users, :province, null: true, foreign_key: true
  end
end
