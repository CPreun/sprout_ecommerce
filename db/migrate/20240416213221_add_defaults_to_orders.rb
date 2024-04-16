class AddDefaultsToOrders < ActiveRecord::Migration[7.1]
  def change
    change_column_default :orders, :status_id, 1
    change_column_default :orders, :paid, false
  end
end
