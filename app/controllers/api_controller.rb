class ApiController < ActionController::Base
  rescue_from ApplicationException do |exception|
    render json: { exception: exception.name, reason: exception.reason }, status: 422
  end
end
