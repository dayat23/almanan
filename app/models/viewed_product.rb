class ViewedProduct < ActiveRecord::Base
  attr_accessible :product_id, :total

  belongs_to :product

  def self.viewed(id)
  	product = find_by_product_id(id)
  	if product.blank?
  		self.create!(product_id: id)
  	else
  		product.total += 1
  		product.save!
  	end
  	product
  end
end
