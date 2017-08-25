module Users
  class AuthenticationSaltService
    def initialize(email: nil)
      @email = email
    end

    # @return [String] A hexadecimal number as a string, of length 64 characters
    def salt
      # Return a new salt if no email address was supplied.
      return SecureRandom.hex(32) if @email.blank?

      # Return existing salt if user is present?
      return user.authentication_salt if user.present?

      # If user is not present, hide the fact by hashing the email after salting it.
      Digest::SHA2.hexdigest(@email + Rails.application.secrets.authentication_salt[:hash_salt])
    end

    private

    def user
      @user ||= User.find_by(email: @email)
    end
  end
end
