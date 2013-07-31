class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :product_id
      t.integer :account_member_id
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
