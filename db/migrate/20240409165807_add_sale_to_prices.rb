class AddSaleToPrices < ActiveRecord::Migration[7.1]
  def change
    add_column :prices, :sale, :boolean, default: false
  end
end
