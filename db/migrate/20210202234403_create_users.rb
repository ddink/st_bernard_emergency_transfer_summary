class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    if ENV['RAILS_ENV'] == 'development'
      create_table :users do |t|
        t.boolean :emergency_staff, null: false

        t.timestamps
      end
    else
      # assumes st. bernard application already has users table
      change_table :users do |t|
        t.boolean :emergency_staff, null: false
      end
    end
  end
end
