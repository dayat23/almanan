class AddCodeOrderToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :code_order, :string
  end
end
