module Users
  # Return an unpersisted user to "stand in" for a real one, to prevent public API users from accessing real users.
  #
  # Hides the fact that user isn't registered by supplying an authentication salt that hashes the email after salting
  # it. Also prevents public users from asking for more information than the bare minimum.
  class StandInService
    def initialize(email)
      @email = email
    end

    # @return [User] Unpersisted User with unique authentication salt
    def user
      persisted_user = User.find_by(email: @email)
      salt = persisted_user.present? ? persisted_user.authentication_salt : stand_in_authentication_salt
      User.new(email: @email, authentication_salt: salt)
    end

    def stand_in_authentication_salt
      Digest::SHA2.hexdigest(@email + Rails.application.secrets.authentication_salt[:hash_salt])
    end
  end
end
