class Types::QueryType < Types::BaseObject
  field :user, Types::User, description: "Find a User with email address", null: false do
    argument :email, String, required: true
  end

  field :session, Types::Session, description: "Get current session", null: true
  field :sessions, [Types::Session], description: "List sessions for current user", null: false

  field :team, Types::Team, description: "Find a Team with given ID", null: true do
    argument :id, ID, required: true
  end

  def team(id:)
    TeamsResolver.new(context).member(id)
  end

  def user(email:)
    UsersResolver.new(context).member(email)
  end

  def session
    context[:current_session]
  end

  def sessions
    SessionsResolver.new(context).collection
  end
end
