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
    return if context[:current_user].blank?

    context[:current_user].teams.find_by(id: id)
  end

  def user(email:)
    Users::StandInService.new(email).compare(context[:current_user])
  end

  def session
    context[:current_session]
  end

  def sessions
    context[:current_user]&.sessions || []
  end
end
