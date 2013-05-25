class CreateCheckItems < ActiveRecord::Migration
  def change
    create_table :check_items do |t|
      t.string :description
      t.boolean :done
      t.integer :wedding_id

      t.timestamps
    end
  end
end
