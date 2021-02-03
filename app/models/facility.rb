class Facility < ApplicationRecord
  has_many :admissions
  validates_presence_of :name
end
