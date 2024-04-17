class Order < ApplicationRecord
  belongs_to :status
  belongs_to :user

  has_many :order_items

  def subtotal
    order_items.sum { |item| item.unit_price.to_d * item.quantity.to_i }
  end

  def total
    subtotal + (gst.present? ? gst : 0 * subtotal) + (pst.present? ? pst : 0 * subtotal) + (hst.present? ? hst : 0 * subtotal)
  end
end
