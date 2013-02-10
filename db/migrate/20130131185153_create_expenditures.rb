class CreateExpenditures < ActiveRecord::Migration
  def change
    create_table :expenditures do |t|
      t.integer :wedding_id
      t.integer :cost
      t.string :description

      t.timestamps
    end
  end
end
