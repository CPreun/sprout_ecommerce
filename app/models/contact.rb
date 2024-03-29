class Contact < ApplicationRecord
  belongs_to :province

  def self.ransackable_attributes(auth_object = nil)
    %w[email phone created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[]
  end
end
