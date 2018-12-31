module Users
  # Can return an unpersisted user to "stand in" for a real one, to prevent public users from accessing full user data.
  #
  # Hides the fact that user isn't registered by supplying an authentication salt that hashes the email after salting
  # it. Also prevents public users from asking for more information than the bare minimum.
  class StandInService
    # @param email [String] Email address of user whose details are being requested.
    def initialize(email)
      @email = email
    end

    # @param current_user [User, nil] Current session's user, if any.
    # @return [User] Full user, if current user, or an unpersisted user with restricted fields.
    def compare(current_user)
      if current_user.present? && current_user.email == @email
        current_user
      else
        user_with_public_fields
      end
    end

    def user_with_public_fields
      salt = persisted_user&.authentication_salt || stand_in_authentication_salt
      User.new(email: @email, authentication_salt: salt)
    end

    def persisted_user
      @persisted_user ||= User.find_by(email: @email)
    end

    def stand_in_authentication_salt
      Digest::SHA2.hexdigest(@email + Rails.application.secrets.authentication_salt[:hash_salt])
    end
  end
end
