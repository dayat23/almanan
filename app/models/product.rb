class Product < ActiveRecord::Base
  attr_accessible :category_id, :code_product, :name_product, :status, :stock, :price

  belongs_to :category
  
  has_many :line_items
  has_many :orders
  has_many :review_products
  has_many :viewed_products
  has_many :photo_products

  def self.product_sale
  	find(:all, conditions: ["status = 1 AND stock > 0"])
  end
end
