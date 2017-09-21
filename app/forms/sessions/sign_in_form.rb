module Sessions
  class SignInForm < Reform::Form
    property :email, virtual: true, validates: { presence: true, email: true }
    property :password, virtual: true, validates: { presence: true }

    def save
      user = Users::AuthenticationService.new(email, password).authenticate
      Sessions::CreateService.new(user).create
    end
  end
end
