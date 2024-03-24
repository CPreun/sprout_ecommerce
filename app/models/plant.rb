class Plant < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :plant_subcategories_id, presence: true

  has_one_attached :image

  belongs_to :plant_subcategory
  belongs_to :seed_type

  has_many :plant_sunlight_amounts
  has_many :sunlight_amounts, through: :plant_sunlight_amounts

  has_many :prices
end
