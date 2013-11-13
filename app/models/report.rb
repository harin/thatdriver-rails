class Report < ActiveRecord::Base
  belongs_to :user
  belongs_to :taxi

  validates_presence_of :user_id, :taxi_id, :action_type


  def json_summary
    json = self.as_json
    json[:plate_no] = Taxi.where(id: self.taxi_id).first.plate_no
    return json
  end
end
