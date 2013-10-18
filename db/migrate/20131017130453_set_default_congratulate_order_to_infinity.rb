class SetDefaultCongratulateOrderToInfinity < ActiveRecord::Migration
  def up
    change_column :guests, :congratulate_order, :integer, default: 999999
    Guest.all.each {|guest| guest.update_attributes!(congratulate_order: 999999)}
  end

  def down
    change_column :guests, :congratulate_order, default: 0
    Guest.all.each {|guest| guest.update_attributes!(congratulate_order: 0)}
  end
end
