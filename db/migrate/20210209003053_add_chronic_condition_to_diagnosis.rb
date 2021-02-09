class AddChronicConditionToDiagnosis < ActiveRecord::Migration[6.1]
  def change
    add_column :diagnoses, :chronic_condition, :boolean
  end
end
