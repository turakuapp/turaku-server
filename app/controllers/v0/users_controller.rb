module V0
  class UsersController < ApiController
    skip_before_action :authenticate_user_with_auth_token, only: %i[create authentication_salt]

    # GET /api/v0/users?email=
    def authentication_salt
      salt = Users::AuthenticationSaltService.new(email: params[:email]).salt
      render(json: { salt: salt })
    end

    # POST /api/v0/users?registration_params
    def create
      registration_form = Users::RegistrationForm.new(User.new)

      if registration_form.validate(registration_params)
        user = registration_form.save
        render json: user
      else
        # TODO: Should be handled as a standard ValidationFailureException response from the API, which the client can then handle.
        render json: registration_form.errors
      end
    end

    private

    def registration_params
      params.require(:user).permit(:name, :email, :password, :authentication_salt)
    end
  end
end
