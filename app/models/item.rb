class Item < ActiveRecord::Base
  has_one :found
  has_one :user, through: :found

  has_one :lost
  has_one :user, through: :lost

  belongs_to :taxi

  after_initialize :init

  def init
    self.returned = false if (self.has_attribute? :returned) && self.returned.nil?
  end

  def finder
    self.found.user
  end

  def loser
    self.lost.user
  end

end
