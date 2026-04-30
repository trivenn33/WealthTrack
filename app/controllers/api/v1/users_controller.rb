module Api
    module V1
        class UserController < ApplicationController
            def me
                render json: {
                    id: current_user.id,
                    email: current_user.email
                }
            end
        end
    end 
end