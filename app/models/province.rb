class Province < ApplicationRecord
    validates :province , presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true

    has_many :contacts
    has_many :users

    def self.ransackable_attributes(auth_object = nil)
        %w[province code created_at updated_at]
    end

    def self.ransackable_associations(auth_object = nil)
        %w[contacts]
    end
end
