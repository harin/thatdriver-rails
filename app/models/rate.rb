class Rate < ActiveRecord::Base
  belongs_to :user
  belongs_to :taxi
  validates :user_id, :taxi_id, :rating, presence: true
end
