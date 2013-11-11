class Taxi < ActiveRecord::Base
  has_many :rates
  has_many :lost_items, class_name: "Item"
  validates :plate_no, presence:true, uniqueness: true, format:{with:/\d?[ก-ฮ][ก-ฮ]\d{1,4}/, message:"does not match plate number format 1aa1111"}
  validates :province, inclusion: PROVINCE, allow_blank: true
  
  # PROVINCEs = %w(djsjfvf fdfs)

  after_initialize :custom_init
  def custom_init
    #set default for returned to be false

    #set province default to bangkok
    self.province = 'กรุงเทพมหานคร' if (self.has_attribute? :province) && self.province.nil?
  end

  def ratable_by_user?(user)
    if user
      last_rated = user.rates.where(taxi_id:self.id).pluck(:updated_at).max
      #check if rated in the same taxi in the last 24 hours
      if last_rated.nil?
        #first rating
        return true
      else
        #rate more than once
        elapse_time = (Time.now - last_rated.to_time)/3600
        if elapse_time > 24
          #already 24 hours
          return true
        else
          #not 24 hours yet
          return false
        end
      end
    end
  end

  def average_rating
    ratings = self.rates.pluck(:rating) #find rating for this taxi and get only the rating column
    if ratings.count > 0
      sum = ratings.sum.to_f #sum the array
      average =  (sum / ratings.count).round(3)
    else
      return 0
    end

  end

  def summary(limit = 10)
    ratings = self.rates.order("updated_at DESC")
    ratings_array = []

    likes = 0
    dislikes = 0
    neutral = 0
    ratings.each do |rate|
      rate_hash = {
        comment:rate.comment,
        timestamp:rate.updated_at.to_i, 
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
    data[:ratings] = ratings_array.take(limit) # limit to 10 ratings
    data[:likes] = likes
    data[:dislikes] = dislikes
    data[:neutral] = neutral
    data[:taxi] = self.as_json
    data[:reported_lost_items] = self.lost_items.count

    return data
  end
end
