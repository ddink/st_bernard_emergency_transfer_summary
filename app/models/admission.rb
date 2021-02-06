require 'date_time_format'
require 'description_format'

class Admission < ApplicationRecord
  include DateTimeFormat
  include DescriptionFormat

  has_many :diagnoses
  has_many :symptoms
  has_many :observations
  belongs_to :patient
  belongs_to :facility
  alias_attribute :moment, :created_at

  def diagnosis_description
    formatted_description(diagnoses)
  end
end
