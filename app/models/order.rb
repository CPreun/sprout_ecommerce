class Order < ApplicationRecord
  validates :user_id, presence: true
  validates :status_id, presence: true
  validates :paid, inclusion: { in: [true, false] }

  belongs_to :status
  belongs_to :user

  has_many :order_items
  has_many :plants, through: :order_items

  def self.ransackable_attributes(auth_object = nil)
    %w[paid status_id user_id shipping_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[status user]
  end

  accepts_nested_attributes_for :order_items, allow_destroy: true

  def subtotal
    order_items.sum { |item| item.unit_price.to_d * item.quantity.to_i }
  end

  def total
    subtotal + (gst.present? ? gst : 0 * subtotal) + (pst.present? ? pst : 0 * subtotal) + (hst.present? ? hst : 0 * subtotal)
  end
end
