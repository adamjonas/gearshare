class Item < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :users, :class_name => "User"

end
