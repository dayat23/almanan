class City < ActiveRecord::Base
  attr_accessible :city_status, :name, :state_id

  belongs_to :state
  has_many :account_members
end
