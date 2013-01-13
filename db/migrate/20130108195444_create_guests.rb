class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :city
      t.string :status

      t.timestamps
    end
  end
end