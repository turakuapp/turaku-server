class SessionsResolver < ApplicationResolver
  def collection
    return Session.none if current_user.blank?

    current_user.sessions
  end
end
