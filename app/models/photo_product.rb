class PhotoProduct < ActiveRecord::Base
  attr_accessible :description, :image_product, :product_id

  belongs_to :product

  mount_uploader :image_product, ImageProductUploader
end
