class CreateAdmissions < ActiveRecord::Migration[6.1]
  def change
    create_table :admissions do |t|
      t.datetime :moment
      t.integer :facility_id

      t.timestamps
    end
  end
end
