module Sessions
  class CreateService
    # @param user [User] User for whom to create new session.
    def initialize(user)
      @user = user
    end

    # @return [Session] Newly created session.
    def create
      session = Session.create!(user: @user, last_used_at: Time.zone.now, token_hash: token_hash)
      session.token = token
      session
    end

    private

    def token
      @token ||= SecureRandom.uuid
    end

    def token_hash
      Digest::SHA256.hexdigest(token)
    end
  end
end
