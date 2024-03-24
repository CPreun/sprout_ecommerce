class PlantCategory < ApplicationRecord
    validates :plant_category, presence: true, uniqueness: true

    has_many :plant_subcategories
    has_many :plants, through: :plant_subcategories

    def self.ransackable_attributes(auth_object = nil)
        %w[plant_category created_at updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
        []
    end

    accepts_nested_attributes_for :plant_subcategories, allow_destroy: true
end
