class CreateWeddings < ActiveRecord::Migration
  def change
    create_table :weddings do |t|
      t.integer :user_id

      t.timestamps
    end
    add_index :weddings, :user_id
  end
end
