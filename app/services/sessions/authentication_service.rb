module Sessions
  # Authenticates an incoming token.
  class AuthenticationService
    # @param token [String] Token string received from user.
    def initialize(token)
      @token = token
    end

    # @return [User] User corresponding to auth_token, or nil.
    def authenticate
      return if @token.blank?
      token_hash = Sessions::TokenHashService.new(@token).hash
      Session.find_by(token_hash: token_hash)
    end
  end
end
