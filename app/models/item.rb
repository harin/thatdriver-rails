class Item < ActiveRecord::Base
  #associations
  # has_one :found
  # has_one :user, through: :found

  # has_one :lost
  # has_one :user, through: :lost

  belongs_to :taxi
  belongs_to :founder, class_name: "User"
  belongs_to :loser, class_name: "User"


  #validations

  after_initialize :init

  # validate :has_lost_or_found_user

  def has_lost_or_found_user
    if self.item_type == 0 and self.lost or self.item_type == 1 and self.found
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

  # def finder
  #   self.found.user
  # end

  # def loser
  #   self.lost.user
  # end

end
#type: 1 (found) or 0 (lost)
