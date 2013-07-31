class ReviewProduct < ActiveRecord::Base
  attr_accessible :account_member_id, :description, :product_id, :status

  belongs_to :account_member
  belongs_to :product

  validates_presence_of :description, message: 'tidak boleh kosong'
end
