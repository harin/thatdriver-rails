module Api
  module V1
    class TaxisController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!, only:[:rate_taxi]


      def get_taxi
        begin
          plate_no = params[:plate_no]
          taxi = Taxi.find_or_create_by(plate_no: plate_no)
          data = taxi.summary #taxi_json_with_ratings(taxi)

          render  json: {data:data, success:true}
        rescue Exception => e
          render  json:{success:true, message: e.to_s}
        end

      end

      def rate_taxi
        plate_no = params[:plate_no]
        begin
          taxi = Taxi.find_or_create_by(plate_no: plate_no)
          taxi.rates.create!(comment: params[:comment], rating: params[:vote], user_id:@user.id)
          render json: {success: true}
        rescue Exception => e
          puts "message->#{e.class}"
          render json: {success: false, message: e.to_s}
        end
      end 


      def ratings_summary
        begin

          if params.has_key?(:limit)
            limit = [params[:limit].to_i,20].min
          else
            limit = 5
          end
          taxis = Taxi.all
          #sort the taxi by the average rating method
          sorted_by_rating = taxis.sort do |a,b|
            a.average_rating <=> b.average_rating
          end

          #best and worst taxi 
          highest_rated_taxis = sorted_by_rating.reverse.take(limit)
          lowest_rated_taxis = sorted_by_rating.take(limit)

          #most popular taxi = most rated
          most_popular_taxis = taxis.sort do |a,b|
            a.rates.count <=> b.rates.count
          end.take(limit)

          #filter out unnecessary content
          filter = Proc.new do |taxi|
            json = taxi.as_json(only:[:id, :plate_no, :owner, :color])
            json[:average_rating] = taxi.average_rating
            json
          end

          highest_rated_taxis.map! &filter
          lowest_rated_taxis.map! &filter
          most_popular_taxis.map! &filter

          #return
          render json:{success: true, data:{highest_rated: highest_rated_taxis, lowest_rated: lowest_rated_taxis, most_popular: most_popular_taxis}}
        rescue Exception => e
          render json: {success: false, message: e.to_s}
        end
      end

      #end class
    end
    #end module V1
  end
  #end module Api
end
