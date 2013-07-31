class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :status

  has_many :products, dependent: :restrict

  def to_label
  	"#{self.name}"
  end
end
