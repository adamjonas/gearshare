class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest

  has_many :shared_items #, :class_name => :items, :foreign_key => :owner_id

  has_many :friendships
  has_many :friends, :through => :friendships
  #the following assoc help a user see who has added them as friends
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  # has_secure_password
  # validates_presence_of :password, :on => :create

end
