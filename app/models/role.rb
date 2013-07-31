class Role < ActiveRecord::Base
  attr_accessible :name, :status

  has_many :account_members
end
