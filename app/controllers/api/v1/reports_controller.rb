module Api
  module V1
    class ReportsController < ApiController
      before_filter :authenticate_user_from_token!

      #params last_iso_timestamp
      def index
        begin
          limit = 10

          if params.has_key? :last_iso_timestamp
            from_time = params[:last_iso_timestamp]
          else
            from_time = Time.now
          end
          reports = Report.where("updated_at < ?",from_time).order('updated_at DESC').limit(limit)

          reports = reports.map do |report|
            report.json_summary
          end

          render json:{success:true, reports: reports}
          
        rescue => e
          render json:{success:false, message: e.to_s}, status: 422
        end
      end

      # POST /reports
      def create  
        begin
          plate_no = params[:plate_no]

          taxi = Taxi.where(plate_no:plate_no).first

          if taxi.nil?
            taxi = Taxi.create!(plate_no:plate_no)
          end

          filtered_params = report_params
          filtered_params[:taxi_id] = taxi.id
          report = @user.reports.create!(filtered_params)

          render json: {success:true, report: report.json_summary}
        rescue StandardError => e
          render json:{success:false, message: e.to_s}, status: 422
        end
      end

      # GET /reports/id
      def show
        report = Report.where(id:params[:id]).first

        if report
          render json:{success:true, report:report.json_summary}
        else
          render json:{success:false, message:"report not found"}, status: 404
        end
      end

      # PATCH/PUT /reports/id
      def update
        report = Report.where(id: params[:id]).first

        if report.update(report_params)
          render json:{success: true, report: report.json_summary}
        else
          render json:{success:false, message: "report update failed"}, status: 422
        end
      end

      def destroy

      end

    private
      def report_params
        params.permit(:description,:action_type, :location, :time)
      end


    end
  end
end