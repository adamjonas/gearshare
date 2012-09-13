class SharedItem < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :item

  def self.lent
  	where(:status => "LENT")
  end

  def self.approved
  	where(:status => "APPROVED")
  end

  def self.open
  	where(:status => "Open")
  end

  def status

  end
  
  def approved?
  	true if status == "APPROVED"
  end
end


# shared_items

# id			user_id			item_id				status
# 1				1				1				
# 												APPROVED
# 												LENT
# current_user.shared_items.lent