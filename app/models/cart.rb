class Cart < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :line_items, dependent: :destroy
  has_many :orders

  def add_product(product_id)
    current_item = line_items.find_by_product_id(product_id)
    if current_item
      if current_item.quantity == current_item.product.stock
        return false
      else
        current_item.quantity += 1
      end
    else
      current_item = line_items.build(:product_id => product_id)
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  def sisa_stok
    line_items.each do |line_item|
      if line_item.order.status > 0
        sisa = line_item.product.stock - line_item.quantity
        line_item.product.update_attribute :stock, sisa
      else
        nambah = line_item.product.stock + line_item.quantity
        line_item.product.update_attribute :stock, nambah
      end
    end
  end
end
