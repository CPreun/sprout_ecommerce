class PlantCategory < ApplicationRecord
    validates :plant_category, presence: true, uniqueness: true

    has_many :plant_subcategories
end
