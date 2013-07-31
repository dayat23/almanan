class AddDetailsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :cart_id, :integer
    add_column :orders, :total_all_price_dollar, :decimal, precision: 10, scale: 2
  end
end
