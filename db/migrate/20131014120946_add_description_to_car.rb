class AddDescriptionToCar < ActiveRecord::Migration
  def up
    add_column :cars, :description, :string
  end

  def down
    remove_column :cars, :description
  end
end
