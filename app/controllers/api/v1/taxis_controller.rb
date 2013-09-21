module Api
  module V1
    class TaxisController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!, only:[:rate_taxi]


      def get_taxi
        plate_no = params[:plate_no]
        taxi = Taxi.find_by(plate_no: plate_no)

        #if taxi doesn't exist, create a new one
        unless taxi
          taxi = Taxi.create(plate_no: plate_no)
        end

        data = taxi_json_with_ratings(taxi)

        render  json: {data:data, success:true}
      end

      def rate_taxi
        plate_no = params[:plate_no]
        taxi = Taxi.find_by(plate_no: plate_no)

        begin
          taxi.rates.create!(comment: params[:comment], rating: params[:vote], user_id:@user.id)
          render json: {success: true}
        rescue Exception => e
          puts "message->#{e.class}"
          render json: {success: false, message: e.to_s}
        end

      end
      
# doesn't fucking work
      # def restrict_access
      #   puts '****************hey'
      #   authenticate_or_request_with_http_token do |token, options|
      #     true
      #   end
      # end


    end
  end
end
