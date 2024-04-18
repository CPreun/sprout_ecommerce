class AddStripeIdToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :stripe_id, :string
  end
end
