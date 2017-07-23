module Sessions
  # Creates a new session.
  class CreateService
    # @param user [User] User for whom to create new session.
    def initialize(user)
      @user = user
    end

    # @return [Session] Newly created session.
    def create
      token = SecureRandom.uuid
      token_hash = Sessions::TokenHashService.new(token).hash
      session = Session.create!(user: @user, last_used_at: Time.zone.now, token_hash: token_hash)
      session.token = token
      session
    end
  end
end
