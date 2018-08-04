class WelcomeController < ApplicationController
  skip_before_action :authorize_request

  def index
    response = { message: "Welcome to CARMS API" }
    json_response(response)
  end
end
