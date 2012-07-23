class Item < ActiveRecord::Base
  attr_accessible :category, :name

  belongs_to :users#, :class => :user

end
