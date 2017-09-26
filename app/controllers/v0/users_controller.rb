module V0
  class UsersController < ApiController
    skip_before_action :authenticate_user_with_auth_token, only: %i[create authentication_salt]

    # GET /api/v0/users/authentication_salt?email=
    def authentication_salt
      @salt = Users::AuthenticationSaltService.new(email: params[:email]).salt
    end

    # POST /api/v0/users?registration_params
    def create
      registration_form = Users::RegistrationForm.new(User.new)

      unless registration_form.validate(registration_params)
        raise ValidationFailureException, registration_form.errors
      end

      registration_form.save
      head :ok
    end

    private

    def registration_params
      params.require(:user).permit(:name, :email, :password, :authentication_salt)
    end
  end
end
