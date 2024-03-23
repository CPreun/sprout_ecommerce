class SeedType < ApplicationRecord
    validates :seed_type, presence: true, uniqueness: true

    has_many :plants
end
