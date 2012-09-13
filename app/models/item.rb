class Item < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :owner, :class_name => "User", :foreign_key => "user_id"


end
