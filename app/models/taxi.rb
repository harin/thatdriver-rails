class Taxi < ActiveRecord::Base
  has_many :rates
  has_many :lost_items, class_name: "Item"
  validates :plate_no, presence:true, uniqueness: true

end
