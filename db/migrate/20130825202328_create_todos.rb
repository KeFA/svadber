class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.boolean :done
      t.string :description
      t.references :wedding, index: true

      t.timestamps
    end
  end
end
