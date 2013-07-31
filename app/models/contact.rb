class Contact < ActiveRecord::Base
  attr_accessible :email, :full_name, :message, :subject, :status

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates_presence_of :full_name, message: "tidak boleh kosong"
  validates_format_of :email, with: email_regex, message: "tidak valid"
  validates_presence_of :email, message: "tidak boleh kosong"
  validates_presence_of :subject, message: "tidak boleh kosong"
  validates_presence_of :message, message: "tidak boleh kosong"
end
