class Item < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :owner, :class => :user
  
end
