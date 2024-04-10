class Plant < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :plant_subcategory_id, presence: true
  validates :prices, presence: true

  # belongs_to :plant_category
  belongs_to :plant_subcategory
  belongs_to :seed_type, optional: true

  has_many :plant_sunlight_amounts
  has_many :sunlight_amounts, through: :plant_sunlight_amounts

  has_many :prices

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    %w[name latin_name family_name plant_subcategory_id created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[plant_subcategory]
  end

  # accepts_nested_attributes_for :plant_category, allow_destroy: false
  accepts_nested_attributes_for :plant_subcategory, allow_destroy: false
  accepts_nested_attributes_for :prices, allow_destroy: true
  accepts_nested_attributes_for :sunlight_amounts, allow_destroy: false
  accepts_nested_attributes_for :plant_sunlight_amounts, allow_destroy: true
  accepts_nested_attributes_for :seed_type, allow_destroy: false
end
