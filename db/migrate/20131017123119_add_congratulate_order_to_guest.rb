class AddCongratulateOrderToGuest < ActiveRecord::Migration
  def change
    add_column :guests, :congratulate_order, :integer, default: 0
  end
end
