module Api
  module V1
    class ApiController < ActionController::Base

      def get_token
        
        begin
          username = params[:username]
          password = params[:password]
          user = User.find_by(username:username)
          if user
            if user.valid_password?(password)
              render json: {auth_token: user.authentication_token, success:true, user: user.summary}
            else
              raise
            end
          else
            raise # go to the rescue block
          end
        rescue Exception =>e
          render json: {success:false, message:'authentication failed'}, status: :unauthorized
        end
      end

      def register
        begin
          puts params
          
          username = params[:username]
          password = params[:password]

          user = User.new(username: username, password:password)
          if params.has_key? :first_name
            user.first_name = params[:first_name]
          end
          if params.has_key? :last_name
            user.last_name = params[:last_name]
          end
          if params.has_key? :email
            user.email = params[:email]
          end
          if params.has_key? :phone
            user.phone = params[:phone].gsub(/\s/,'')
          end

          user.save!

          render json: {success:true, auth_token: user.authentication_token, first_name: user.first_name, last_name: user.last_name, email:user.email , phone:user.phone, username:user.username}
        rescue Exception => e
          render json: {success:false, message:e.to_s}
        end
      end

      #helper methods
      private
      def authenticate_user_from_token!
        user_token = params[:auth_token].presence
        @user       = user_token && User.find_by(authentication_token:user_token)
        # print '***********'
        # puts request.authorization.to_s
        # puts request.headers['Authorization'].to_s
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

