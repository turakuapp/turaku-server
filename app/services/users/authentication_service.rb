module Users
  class AuthenticationService
    # @param email [String] Email address of user requiring authentication.
    # @param password [String] Password of user requiring authentication.
    def initialize(email, password)
      @email = email
      @password = password
    end

    # @return [User] Authenticated user, if any.
    def authenticate
      user = User.find_by(email: @email)
      raise Sessions::AuthenticationFailureException if user.blank? || !user.valid_password?(@password)
      raise Sessions::UnconfirmedEmailException unless user.confirmed?
      user
    end
  end
end
