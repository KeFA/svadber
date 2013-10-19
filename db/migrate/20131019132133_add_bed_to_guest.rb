class AddBedToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :bed_place, :string
    add_column :guests, :bed_cost, :integer
  end
end
