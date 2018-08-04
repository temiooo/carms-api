module V1
  class UsersController < ApplicationController
    skip_before_action :authorize_request, except: :create

    def create
      #ADMIN UPLOADS USER DETAILS
    end

    def login
      response =
        AuthenticateUser.new(user_params[:school_id], user_params[:password]).call

      json_response(response)
    end

    private

    def user_params
      params.permit(
        :name, :school_id, :password, :role_id
      )
    end

  end
end
