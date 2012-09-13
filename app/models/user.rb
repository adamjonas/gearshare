class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :shared_items, :provider, :uid

  has_many :shared_items, :class_name => "Item", :foreign_key => "owner_id"

  has_many :friendships
  has_many :friends, :through => :friendships
  #the following assoc helps a user see who has added them as friends
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_secure_password

  validates_uniqueness_of :email
  validates_presence_of :first_name, :last_name, :email, :on => :create


  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def request_to_borrow_item
  	self.shared_items.build(:item_id => params[:id], :status => :open)
  end

  def name
   "#{first_name}" "#{last_name}"
  end
  


end




# users
# 1			Avi
# 2

# equipment				user_id
# 1			Bat				1



# shared_equipment
# id 				user_id       equipment_id
# 1					2				1


# user has many owned_equipment, :class_name => "Equipment"
# equipment belongs to user
# user has many shared_equipments
# user has many equipments, through => shared_equipment


# equipment
# belongs_to :owner, :class_name => "User", :foreign_key => "user_id"



# person
# id 					name          parent_id
# 1					Batsheva
# 2					Avi					1


# user belongs_to :parent, :class => User, :foreign_key => :parent_id
# user has_many 


# friendship
# user_id				friend_id
# 1					2
# 2					1