class DiagnosticProcedure < ApplicationRecord
  validates_presence_of :description
  alias_attribute :moment, :created_at
end
