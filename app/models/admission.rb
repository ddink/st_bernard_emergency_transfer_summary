class Admission < ApplicationRecord
  has_many :diagnoses
  has_many :symptoms
  has_many :observations
  belongs_to :patient
  belongs_to :facility
  alias_attribute :moment, :created_at
end
