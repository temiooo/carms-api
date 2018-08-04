class ErrorsController < ApplicationController
  skip_before_action :authorize_request

  def unknown_route
    response = { message: "This route does not exist"}
    json_response(response, :not_found)
  end
end
