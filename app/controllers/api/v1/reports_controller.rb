module Api
  module V1
    class ReportsController < ApiController
      before_filter :authenticate_user_from_token!

      def index
        
      end

      def create  
        begin
          report = @user.reports.create!(create_report_params)
          render json: {success:true, report: report.as_json}
        rescue StandardError => e
          render json:{success:false}, status: 422
        end
      end

      def show

      end

      def update

      end

      def destroy

      end

    private
      def create_report_params
        params.permit(:description,:action_type, :location, :plate_no)
      end


    end
  end
end