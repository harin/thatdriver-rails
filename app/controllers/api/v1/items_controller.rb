module Api
  module V1
    class ItemsController < ApiController
      respond_to :json
      before_filter :authenticate_user_from_token!, only:[]
      def report_lost

      end

    end
  end
end
