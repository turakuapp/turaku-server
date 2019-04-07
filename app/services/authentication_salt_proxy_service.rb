class AuthenticationSaltProxyService
  def initialize(email)
    @email = email
  end

  def salt
    requested_user = User.find_by(email: @email)
    requested_user&.authentication_salt || stand_in_authentication_salt
  end

  private

  def stand_in_authentication_salt
    Digest::SHA2.hexdigest(@email + Rails.application.secrets.authentication_salt[:hash_salt])
  end
end
