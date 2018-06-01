module Users
  # Return an unpersisted user to "stand in" for a real one, to prevent API users from detecting actual ones.
  #
  # Hides the fact that user isn't registered by supplying an authentication salt that hashes the email after salting it.
  class StandInService
    def initialize(email)
      @email = email
    end

    # @return [User] Unpersisted User with unique authentication salt
    def user
      salt = Digest::SHA2.hexdigest(@email + Rails.application.secrets.authentication_salt[:hash_salt])

      User.new(email: @email, authentication_salt: salt)
    end
  end
end
