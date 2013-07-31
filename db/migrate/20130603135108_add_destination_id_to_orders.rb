class AddDestinationIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :destination_id, :integer
  end
end
