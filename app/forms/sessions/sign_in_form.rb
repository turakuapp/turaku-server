module Sessions
  class SignInForm < Reform::Form
    property :email, virtual: true, validates: { presence: { message: "BlankEmail" }, email: { message: "InvalidEmail" } }
    property :password, virtual: true, validates: { presence: { message: "BlankPassword" } }

    validate :must_be_authentic

    def must_be_authentic
      begin
        @user = Users::AuthenticationService.new(email, password).authenticate
      rescue Sessions::AuthenticationFailureException
        errors[:base] << "AuthenticationFailure"
      rescue Sessions::UnconfirmedEmailException
        errors[:base] << "UnconfirmedEmail"
      end
    end

    def save
      Sessions::CreateService.new(@user).create
    end
  end
end
