class Observation < ApplicationRecord
  belongs_to :admission
  validates_presence_of :description
  alias_attribute :moment, :created_at
end
