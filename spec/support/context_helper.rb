module ContextHelper
  def self.authorized_context(user)
    session = FactoryBot.create(:session, user: user)

    {
      current_user: user,
      current_session: session,
      auth_token: session.token
    }
  end
end
