class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :wedding_id
      t.string :driver
      t.string :phone_number
      t.integer :hours_count, default: 0
      t.integer :cost_for_hour, default: 0
      t.integer :cost_for_decorations, default: 0
      t.integer :paid, default: 0
      t.integer :seats_count

      t.timestamps
    end
  end
end
