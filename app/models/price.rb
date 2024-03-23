class Price < ApplicationRecord
  validates :price, :plant_id, presence: true

  belongs_to :plant
end
