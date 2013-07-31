class RemoveLineItemIdFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :line_item_id
  end

  def down
    add_column :orders, :line_item_id, :integer
  end
end
