module V0
  class SessionsController < ApiController
    skip_before_action :authenticate_user_with_auth_token, only: %i[create]

    # POST /api/v0/session?email=&password=
    def create
      user = Users::AuthenticationService.new(params[:email], params[:password]).authenticate
      raise Sessions::AuthenticationFailureException if user.blank?
      session = Sessions::CreateService.new(user).create
      render json: SessionSerializer.new(session)
    end

    # DELETE /api/v0/session
    # DELETE /api/v0/sessions/:id
    def destroy
      session = params[:id].present? ? Session.find(params[:id]) : current_session
      Sessions::DestroyService.new(session).execute
      head :ok
    end
  end
end
