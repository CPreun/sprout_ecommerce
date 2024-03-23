class PlantSunlightAmount < ApplicationRecord
  validates_uniqueness_of :plant_id, scope: :sunlight_amount_id

  belongs_to :plant
  belongs_to :sunlight_amount
end
