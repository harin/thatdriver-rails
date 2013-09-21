class Taxi < ActiveRecord::Base
  has_many :rates
  has_many :found_items
  validates :plate_no, presence:true
end
