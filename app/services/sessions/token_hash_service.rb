module Sessions
  # Hashes a token.
  class TokenHashService
    # @param token [String] An authentication token.
    def initialize(token)
      @token = token
    end

    # @return [String] Hash of the supplied token.
    def hash
      Digest::SHA256.hexdigest(@token)
    end
  end
end
