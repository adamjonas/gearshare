class SharedItem < ActiveRecord::Base
  # attr_accessible :title, :body

  has_many :user_ids
  has_many :item_ids
  
end
