class CreateReviewProducts < ActiveRecord::Migration
  def change
    create_table :review_products do |t|
      t.integer :account_member_id
      t.integer :product_id
      t.text :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
