require 'date_time_format'

class DiagnosticProcedure < ApplicationRecord
  include DateTimeFormat
  validates_presence_of :description
  alias_attribute :moment, :created_at
end
