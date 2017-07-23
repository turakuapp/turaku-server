module V0
  class SessionsController < ApiController
    # POST /api/sessions?email=&password=
    def create
      user = Users::AuthenticationService.new(params[:email], params[:password]).authenticate
      raise Sessions::AuthenticationFailureException if user.blank?
      session = Sessions::CreateService.new(user).create
      render json: SessionSerializer.new(session)
    end
  end
end
