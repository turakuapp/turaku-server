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
      return if user.blank?
      user if user.valid_password?(@password)
    end
  end
end
