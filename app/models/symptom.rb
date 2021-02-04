class Symptom < ApplicationRecord
  belongs_to :admission
  validates_presence_of :description
end
