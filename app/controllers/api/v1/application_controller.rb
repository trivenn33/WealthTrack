module Api
  module V1
    class ApplicationController < ::ApplicationController
      before_action :authenticate_request
      private
      def authenticate_request
        token = request.headers['Authorization'].to_s.split(' ').last

        decoded_token = JsonWebToken.decode(token)

        if decoded_token
          @current_user = User.find_by(id: decoded_token[:user_id])
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
      end
      def current_user
        @current_user
      end
    end
  end
end