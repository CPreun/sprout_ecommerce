class RemoveTaxRatesFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :pst_rate
    remove_column :order_items, :gst_rate
    remove_column :order_items, :hst_rate
  end
end
