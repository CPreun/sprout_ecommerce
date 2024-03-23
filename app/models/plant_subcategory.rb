class PlantSubcategory < ApplicationRecord
  validates :plant_subcategory, presence: true, uniqueness: true
  
  belongs_to :plant_category

  has_many :plants
end
