class OrderItem < ApplicationRecord
  belongs_to :plant
  belongs_to :order
end
