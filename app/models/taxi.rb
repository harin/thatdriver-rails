class Taxi < ActiveRecord::Base
  has_many :rates
  has_many :lost_items, class_name: "Item"
  validates :plate_no, presence:true, uniqueness: true


  def summary
    ratings = Rate.where(taxi_id: self.id)
    ratings_array = []

    likes = 0
    dislikes = 0
    neutral = 0
    ratings.each do |rate|
      rate_hash = {
        comment:rate.comment,
        timestamp:rate.created_at.to_i, 
        rating:rate.rating
      }
      ratings_array << rate_hash

      case rate.rating
      when -1 then dislikes += 1
      when 0 then neutral += 1
      when 1 then likes += 1
      end
    end

    data = {}
    data[:ratings] = ratings_array
    data[:likes] = likes
    data[:dislikes] = dislikes
    data[:neutral] = neutral
    data[:taxi] = self.as_json
    data[:reported_lost_items] = self.lost_items.count

    return data
  end
end
