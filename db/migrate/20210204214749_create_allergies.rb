class CreateAllergies < ActiveRecord::Migration[6.1]
  def change
    create_table :allergies do |t|
      t.text :description
      t.integer :patient_id

      t.timestamps
    end
  end
end
