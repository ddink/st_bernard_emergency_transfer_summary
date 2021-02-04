class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :medical_record, null: false, unique: true
      t.datetime :dob
      t.integer :gender, default: 0

      t.timestamps
    end
  end
end
