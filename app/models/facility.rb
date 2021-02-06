class Facility < ApplicationRecord
  has_many :admissions
  has_many :patients, through: :admissions

  validates_presence_of :name
end
