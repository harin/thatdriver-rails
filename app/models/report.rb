class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :taxi

  validates_presence_of :user_id, :taxi_id, :action_type
end
