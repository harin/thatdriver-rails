class Item < ActiveRecord::Base
  has_one :found
  has_one :user, through: :found

  has_one :lost
  has_one :user, through: :lost
end
