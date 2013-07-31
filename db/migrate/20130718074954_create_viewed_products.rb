class CreateViewedProducts < ActiveRecord::Migration
  def change
    create_table :viewed_products do |t|
      t.integer :product_id
      t.integer :total, default: 1

      t.timestamps
    end
  end
end
