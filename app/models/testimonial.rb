class Testimonial < ActiveRecord::Base
  attr_accessible :account_member_id, :description, :status

  belongs_to :account_member

  validates_presence_of :description, message: 'tidak boleh kosong'
end
