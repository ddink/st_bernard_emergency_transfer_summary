class CreateSymptoms < ActiveRecord::Migration[6.1]
  def change
    create_table :symptoms do |t|
      t.text :description
      t.integer :admission_id

      t.timestamps
    end
  end
end
