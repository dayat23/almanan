class State < ActiveRecord::Base
  attr_accessible :name, :state_status

  has_many :cities
  has_many :account_members
  has_many :destinations
end
