module Api
  module V1
    class ItemsController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!
      #GET /api/get_my_report
      def get_my_report
        if @user # provided by authenticate_user_from_token!

          found_items = []
          founds = @user.founds
          founds.each do |f|
            found_items << f.item unless f.item.nil?
          end

          lost_items = []
          losts = @user.losts
          losts.each do |l|
            lost_items << l.item unless l.item.nil?
          end


          render json:{success: true, data: {found_items: found_items.as_json, lost_items: lost_items}}
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
          lost = @user.losts.new(item: item)


          if item.save! && lost.save!
            render json:{success:true}
          end
        rescue Exception => e
          #clean up if something fails
          item.destroy unless item.nil?
          lost.destroy unless lost.nil?
          render json:{success:false, message: e.to_s}
        end
      end
      #POST /api/report_found

      def report_found
        begin
          item = new_item_with_params params
          item.when = DateTime.iso8601( params[:time_found])
          found = @user.founds.create(item: item)

          if item.save! && found.save!
            render json:{success:true}
          end
        rescue Exception => e
          #clean up
          item.destroy unless item.nil?
          found.destroy unless item.nil?
          render json:{success:true, message: e.to_s}
        end
      end

      private

      def new_item_with_params(params)
        item = Item.new
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
