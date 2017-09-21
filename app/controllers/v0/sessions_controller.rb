module V0
  class SessionsController < ApiController
    skip_before_action :authenticate_user_with_auth_token, only: %i[create]

    # POST /api/v0/sessions?create_params
    def create
      sign_in_form = Sessions::SignInForm.new(Session.new)

      unless sign_in_form.validate(create_params)
        raise ValidationFailureException, sign_in_form.errors
      end

      session = sign_in_form.save
      render json: SessionSerializer.new(session)
    end

    # DELETE /api/v0/session
    # DELETE /api/v0/sessions/:id
    def destroy
      session = params[:id].present? ? Session.find(params[:id]) : current_session
      Sessions::DestroyService.new(session).execute
      head :ok
    end

    private

    def create_params
      params.require(:session).permit(:email, :password)
    end
  end
end
