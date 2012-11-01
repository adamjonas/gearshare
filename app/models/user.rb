class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :shared_items, :provider, :uid, :location

  has_many :shared_items, :class_name => "Item", :foreign_key => "owner_id"

  has_many :friendships
  has_many :friends, :through => :friendships
  #the following assoc helps a user see who has added them as friends
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

 # has_secure_password

  #validates_uniqueness_of :email
 # validates_presence_of :first_name, :last_name, :email, :on => :create

  has_one :location
  accepts_nested_attributes_for :location

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  # def self.from_omniauth(auth)
  #   where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  # end

  # def self.create_from_omniauth(auth)
  #   create! do |user|
  #     user.provider = auth[:provider]
  #     user.uid = auth[:uid]
  #    # user.name = auth[:info][:name]
  #     user.first_name = auth[:info][:first_name]
  #   end
  # end


  def request_to_borrow_item
    self.shared_items.build(:item_id => params[:id], :status => :open)
  end

  def name
   "#{first_name}" "#{last_name}"
  end
  
  def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.first_name = auth["info"]["first_name"]
    user.last_name = auth["info"]["last_name"]
    user.email = auth["info"]["email"]
   
    #location is passed in as a string. need to send user.location an object.
    fblocationstr = auth["extra"]["raw_info"]["location"]["name"]
    location = Location.new
    user.location = location.location_str_to_object(fblocationstr)

    # fblocation = Location.new unless auth["extra"]["raw_info"]["location"]["name"].nil?
    # raise user.location.inspect
    # fblocation.city = = fblocation.to_a.split(,).first
    # fblocaton.state = fblocation.split(,).last
    # user.location = fbrellocation

    #user.token = auth["credentials"]["token"]
    user.save
  end

end

  
  # def self.from_omniauth(auth)
  #   user = where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  #     user.provider = auth["provider"]
  #     user.uid = auth["uid"]
  #     user.name = auth["info"]["name"]
  #     user.first_name = auth["info"]["first_name"]
  #     user.last_name = auth["info"]["last_name"]
  #     user.image = auth["info"]["image"]
  #     user.email = auth["info"]["email"]
  #     user.gender = auth["extra"]["raw_info"]["gender"]
  #     user.location = auth["extra"]["raw_info"]["location"]["name"]          
  #     user.token = auth["credentials"]["token"]
  #     end
  #   user.add_friends
  #   user.save
  #   user
  #   end

#get loop through all friends and push their attributes into the hash
  def add_friends
    # @facebook.get_connection("me", "friends").each do |hash|
    #   self.friends.where(:name => hash['name'], :uid => hash['id']).first_or_create
    # end
  end

  #Koala####

def facebook_connection
  @facebook.get_connections("me", "friends", :fields => "name, id, location")
end

#get loop through all friends and push their attributes into the hash
  # def facebook_friends
  #   facebook_connection(token).each do |hash|
  #     self.friends.where(:name => hash['name'], :uid => hash['id'], :friend_location => hash['location']).first_or_create
  #   end
  # end

#this is the query string I'm looking for... /4205423?fields=id,name,friends.fields(location)


  private

  def facebook
    @facebook ||= Koala::Facebook::API.new(token)
  end


#something like this to check if a friend of your is registered...
  # def registered_friend
  #   uids = @friends.collect(&:uid)
  #   # uids is an array of Facebook UID's, say [1234, 5678, 9012]
  #   registered_friends = User.where('fb_uid IN (?)', uids)
  #   # "SELECT users.* FROM users WHERE (fb_uid IN (1234, 5678, 9012))"
  # end

 
end



# users
# 1     Avi
# 2

# equipment       user_id
# 1     Bat       1



# shared_equipment
# id        user_id       equipment_id
# 1         2       1


# user has many owned_equipment, :class_name => "Equipment"
# equipment belongs to user
# user has many shared_equipments
# user has many equipments, through => shared_equipment


# equipment
# belongs_to :owner, :class_name => "User", :foreign_key => "user_id"



# person
# id          name          parent_id
# 1         Batsheva
# 2         Avi         1


# user belongs_to :parent, :class => User, :foreign_key => :parent_id
# user has_many 


# friendship
# user_id       friend_id
# 1         2
# 2         1