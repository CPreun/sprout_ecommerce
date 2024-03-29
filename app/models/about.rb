class About < ApplicationRecord
    validates :description, presence: true

    has_one_attached :image

    def self.ransackable_attributes(auth_object = nil)
        %w[description created_at updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[]
    end
end
