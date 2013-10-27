module Api
  module V1
    class ItemsController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!
      #GET /api/allreports
      # params - last_iso_timestamp, auth_token
      def get_all_report
        limit = 15
        begin
          if params.has_key? :last_iso_timestamp
            from_time = DateTime.iso8601 params[:last_iso_timestamp]

            items = Item.active_items.order('updated_at DESC').where("updated_at < ?",from_time).limit(limit)
          else 
            items = Item.active_items.order('updated_at DESC').limit(limit)
          end
          #return
          render json:{success:true, lost_and_found: items.take(limit)}      
        rescue Exception => e
          render json:{success:false, message: e.to_s}
        end
      end

      def get_my_report
        begin
          if @user # provided by authenticate_user_from_token.
          limit = 15

          render json:{success: true, data: {found_items: @user.found_items.take(limit).as_json, lost_items: @user.lost_items.take(limit).as_json}}
          else
            render json:{success: false}
          end
        rescue Exception => e
          render json:{success:false, message: e.to_s} 
        end
      end

      #GET /api/v1/my_lost_and_found
      def get_lost_and_found
        begin
          limit = 100

          found_items = @user.found_items
          lost_items = @user.lost_items

          items = found_items + lost_items
          items = items.sort_by(&:created_at).take(limit)

          render json:{success: true, data: {lost_and_found: items}}
        rescue Exception => e
          render json:{success:false, message: e.to_s}
        end
      end

      #POST /api/report_lost
      def report_lost
        begin
          item = new_item_with_params params
          item.when = DateTime.iso8601( params[:time_lost])
          item.item_type = 0
          @user.lost_items << item


          if item.save!
            render json:{success:true, item_id: item.id}
          end
        rescue Exception => e
          #clean up if something fails
          item.destroy unless item.nil?
          render json:{success:false, message: e.to_s}
        end
      end
      #POST /api/report_found

      def report_found
        begin
          item = new_item_with_params params
          item.when = DateTime.iso8601( params[:time_found])
          item.item_type = 1
          @user.found_items << item

          if item.save!
            render json:{success:true, item_id: item.id}
          end
        rescue Exception => e
          #clean up
          item.destroy unless item.nil?
          render json:{success:false, message: e.to_s}
        end
      end
      def update_item
        begin
          item.item_name = params[:item_name] if params.has_key?(:item_name)
          item.description = params[:item_desc] if params.has_key?(:item_desc)
          item.location = params[:location] if params.has_key?(:location)
          item.plate_no = params[:plate_no] if params.has_key?(:plate_no)
          item.taxi_description = params[:taxi_description] if params.has_key? :taxi_description
          item.contact = params[:contact] if params.has_key? :contact

          unless item.plate_no.nil?
            taxi = Taxi.find_or_create_by(plate_no: item.plate_no)
            item.taxi = taxi
          end
          render json:{success: true}
        rescue Exception => e
          render json:{success:false, message: e.to_s}
        end

      end
      def resolve_item
        begin
          item = Item.find(params[:item_id])
          item.returned = true
          item.save!
          render json:{success: true}      
        rescue Exception => e
          render json:{success:false, message: e.to_s}
        end
      end

      def delete_item
        begin
          item = Item.find(params[:item_id])
          item.destroy!
          render json: {success: true}
        rescue Exception => e
          render json: {sucess: false, message: e.to_s}
          
        end

      end

      private

      def new_item_with_params(params)
        item = Item.new
        item.item_name = params[:item_name]
        item.description = params[:item_desc]
        item.location = params[:location]
        item.plate_no = params[:plate_no]
        item.taxi_description = params[:taxi_description]
        item.contact = params[:contact]

        unless item.plate_no.nil?
          taxi = Taxi.find_or_create_by(plate_no: item.plate_no)
          item.taxi = taxi
        end

        return item
      end

    end


  end
end
