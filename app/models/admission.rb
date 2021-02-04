class Admission < ApplicationRecord
  has_many :diagnoses
  has_many :symptoms
  has_many :observations
  has_one :patient
  belongs_to :facility
  alias_attribute :moment, :created_at
end
