module AuthorizeWithUser
  include ActiveSupport::Concern

  def authorize
    raise UnauthorizedMutationException if current_user.blank?
  end
end
