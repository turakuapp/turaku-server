class ApiController < ActionController::Base
  include Pundit
  before_action :authenticate_user_with_auth_token

  helper_method :current_session
  helper_method :current_user

  rescue_from ActiveRecord::RecordNotFound do
    render json: { exception: 'ResourceNotFound', reason: 'The resource you requested could not be found.' }, status: 404
  end

  rescue_from ApplicationException do |exception|
    render json: { exception: exception.name, reason: exception.reason }, status: exception.code
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: { exception: 'ParameterMissing', reason: "The parameter '#{exception.param}' is required for this request." }, status: 422
  end

  protected

  def current_session
    @current_session ||= Sessions::AuthenticationService.new(auth_token).authenticate
  end

  def authenticate_user_with_auth_token
    raise Sessions::TokenAuthenticationFailedException if current_session.blank?

    # Notice we are passing store false, so the user is not actually stored in the session and a token is needed for
    # every request. If you want the token to work as a sign in token, you can simply remove store: false.
    # sign_in @current_session.user, store: false
  end

  def current_user
    return if current_session.blank?
    current_session.user
  end

  def auth_token
    return if request.headers['Authorization'].blank?
    request.headers['Authorization'].split(' ').last
  end
end
