class CreateMedicationOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :medication_orders do |t|
      t.string :name
      t.decimal :dosage
      t.text :necessity
      t.integer :mass_unit, default: 0
      t.integer :medication_route, default: 0
      t.integer :patient_id

      t.timestamps
    end
  end
end
