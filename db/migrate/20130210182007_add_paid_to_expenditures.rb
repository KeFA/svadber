class AddPaidToExpenditures < ActiveRecord::Migration
  def up
    add_column :expenditures, :paid, :integer, default: 0
    Expenditure.all.each do |expenditure|
      expenditure.update_attributes!(paid: 0)
    end
  end

  def down
    remove_column :expenditures, :paid
  end
end
