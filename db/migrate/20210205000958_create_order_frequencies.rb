class CreateOrderFrequencies < ActiveRecord::Migration[6.1]
  def change
    create_table :order_frequencies do |t|
      t.string :value
      t.integer :unit
      t.integer :medication_order_id

      t.timestamps
    end
  end
end
