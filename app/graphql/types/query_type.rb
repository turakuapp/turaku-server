class Types::QueryType < Types::BaseObject
  field :user, Types::User, description: "Find a User with email address", null: false do
    argument :email, String, required: true
  end

  field :session, Types::Session, description: "Get current session", null: false
  field :sessions, [Types::Session], description: "List sessions for current user", null: false

  field :team, Types::Team, description: "Find a Team with given ID", null: false do
    argument :id, ID, required: true
  end

  def team(**args)
    context[:current_user].teams.find_by(id: args[:id])
  end

  def user(**args)
    user = User.find_by(email: args[:email])
    user.present? ? user : Users::StandInService.new(args[:email]).user
  end

  def session
    context[:current_session]
  end

  def sessions
    context[:current_user].sessions
  end
end
