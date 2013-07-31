class Destination < ActiveRecord::Base
  attr_accessible :name, :price, :state_id, :status

  belongs_to :state
  
  has_many :orders
end
