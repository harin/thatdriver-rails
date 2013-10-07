module Api
  module V1
    class ItemsController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!
      #GET /api/get_my_report
      def get_my_report
        if @user # provided by authenticate_user_from_token!
          render json:{success: true, data: @user.lost_items.as_json}
        else
          render json:{success: false}
        end
      end
# {
#   item_name:
#   item_desc:
#   location:
#   plate_number:
#   taxi_desc:
#   contact:
#   time_lost: (datetime.. don't know which format rails like best)
# }
      #POST /api/report_lost
      def report_lost
        begin
          item = new_item_with_params params
          item.when = DateTime.iso8601( params[:time_lost])


          if item.save!
            render json:{success:true}
          end
        rescue Exception => e
          render json:{success:false, message: e.to_s}
        end
      end
      #POST /api/report_found

      def report_found
        begin
          item = new_item_with_params params
          item.when = DateTime.iso8601( params[:time_found])

          if item.save!
            render json:{success:true}
          end

        rescue Exception => e
          puts e
          render json:{success:true, message: e.to_s}
        end
      end

      private

      def new_item_with_params(params)
        item = @user.lost_items.new
        item.item_name = params[:item_name]
        item.description = params[:item_desc]
        item.location = params[:location]
        item.plate_no = params[:plate_number]
        item.taxi_description = params[:taxi_description]
        item.contact = params[:contact]
        # item.when = DateTime.iso8601( params[:time_lost])
        return item
      end

    end


  end
end
