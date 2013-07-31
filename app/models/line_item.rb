class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :product_id, :order_id, :quantity

  belongs_to :cart
  belongs_to :product
  belongs_to :order

  def total_price
    # if product.discount_product.blank? or product.discount_product == 0
    #   product.old_price_product * quantity
    # else
    #   product.new_price_product * quantity
    # end
    product.price * quantity
  end
end
