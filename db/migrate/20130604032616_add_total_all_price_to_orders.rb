class AddTotalAllPriceToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :total_all_price, :decimal
  end
end
