class User < ApplicationRecord
  attribute :emergency_staff, :boolean
  scope :emergency_personnel, -> { where(emergency_staff: true) }
end
