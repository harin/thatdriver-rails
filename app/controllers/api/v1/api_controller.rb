module Api
  module V1
    class ApiController < ActionController::Base

      #helper methods
      private
      def taxi_json_with_ratings(taxi)
        ratings = Rate.where(taxi_id: taxi.id)
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
        data[:taxi] = taxi.as_json

        return data
      end


      def authenticate_user_from_token!
        user_token = params[:auth_token].presence
        @user       = user_token && User.find_by(authentication_token:user_token)
     
        if @user
          # Notice we are passing store false, so the user is not
          # actually stored in the session and a token is needed
          # for every request. If you want the token to work as a
          # sign in token, you can simply remove store: false.
          sign_in @user, store: false
        else
          render json:{success:false, message:'authentication failed'}, status: :unauthorized
        end
      end

    end #end class
  end #end V1
end #end Module Api

