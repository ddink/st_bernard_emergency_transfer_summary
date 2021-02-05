class CreateTreatments < ActiveRecord::Migration[6.1]
  def change
    create_table :treatments do |t|
      t.text :description
      t.text :necessity
      t.integer :patient_id

      t.timestamps
    end
  end
end
