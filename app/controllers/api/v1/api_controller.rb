module Api
  module V1
    class ApiController < ActionController::Base

      def get_token
        
        begin
          username = params[:username]
          password = params[:password]
          user = User.find_by(username:username)
          if user.valid_password?(password)
            render json: {auth_token: user.authentication_token, success:true}
          else
            raise # go to the rescue block
          end
        rescue
          render json: {success:false, message:'authentication failed'}, status: :unauthorized
        end

      end

      def register
        begin
          puts params
          
          username = params[:username]
          password = params[:password]
          first_name = params[:first_name]
          last_name = params[:last_name]
          email = params[:email]

          user = User.create!(username: username, password:password, first_name: first_name, last_name:last_name, email:email)
          render json: {success:true, auth_token: user.authentication_token }
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

