class CreateObservations < ActiveRecord::Migration[6.1]
  def change
    create_table :observations do |t|
      t.text :description
      t.datetime :moment
      t.integer :admission_id

      t.timestamps
    end
  end
end
