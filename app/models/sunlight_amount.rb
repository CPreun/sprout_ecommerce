class SunlightAmount < ApplicationRecord
    validates :amount, presence: true, uniqueness: true

    has_many :plant_sunlight_amounts
    has_many :plants, through: :plant_sunlight_amounts
end
