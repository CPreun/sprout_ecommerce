class PlantSubcategory < ApplicationRecord
  validates :plant_subcategory, presence: true, uniqueness: true
  
  belongs_to :plant_category

  has_many :plants

  def self.ransackable_attributes(auth_object = nil)
    %w[plant_subcategory plant_category_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    ["plant_category"]
  end
end
