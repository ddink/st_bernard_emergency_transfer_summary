class CreateDiagnosticProcedures < ActiveRecord::Migration[6.1]
  def change
    create_table :diagnostic_procedures do |t|
      t.text :description
      t.datetime :moment
      t.integer :patient_id

      t.timestamps
    end
  end
end
