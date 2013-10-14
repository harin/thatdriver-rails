class Item < ActiveRecord::Base
  #associations
  belongs_to :taxi
  belongs_to :founder, class_name: "User"
  belongs_to :loser, class_name: "User"

  #validations
  validates :item_type, inclusion: [1,0]
  validate :has_lost_or_found_user

  after_initialize :init


  def has_lost_or_found_user
    if self.item_type == 0 and self.loser or self.item_type == 1 and self.founder
      #ok
    else
      #doesn't have Lost for type 0 or doesn't have Found for type 1
      errors[:base] << ("Type 0 item must have lost user,Type 1 item must have found user")
    end
  end   

  def init
    #set default for returned to be false
    self.returned = false if (self.has_attribute? :returned) && self.returned.nil?
  end


end
#type: 1 (found) or 0 (lost)
