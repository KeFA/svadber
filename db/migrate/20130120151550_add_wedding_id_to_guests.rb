class AddWeddingIdToGuests < ActiveRecord::Migration
  def change
    add_column :guests, :wedding_id, :integer
    add_index :guests, :wedding_id
  end
end
