class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest

  has many :owned_items, :class => :items, :forgein_key => :owner_id

  # has_secure_password
  # #lacks validation for presence of password
  # validates_presence_of :password, :on => :create

end
