class Types::QueryType < Types::BaseObject
  field :user, Types::User, description: "Find a User with email address", null: false do
    argument :email, String, required: true
  end

  field :session, Types::Session, description: "Get current session", null: false

  def user(**args)
    user = User.find_by(email: args[:email])
    user.present? ? user : Users::StandInService.new(args[:email]).user
  end

  def session
    # The authentication token needs to be taken from the request because we don't store it server-side.
    context[:current_session].tap { |s| s.token = context[:auth_token] }
  end
end
