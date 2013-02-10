class AddDefaultValueToExpenditureCost < ActiveRecord::Migration
  def up
    change_column :expenditures, :cost, :integer, default: 0
  end

  def down
    change_column :expenditures, :cost, :integer, default: nil
  end
end
