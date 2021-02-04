class Diagnosis < ApplicationRecord
  belongs_to :patient
  belongs_to :admission

  validates_presence_of :description
end
