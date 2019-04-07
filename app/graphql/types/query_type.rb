class Types::QueryType < Types::BaseObject
  field :session, Types::Session, description: 'Get current session', null: true
  field :sessions, [Types::Session], description: 'List all sessions of current user', null: false

  field :team, Types::Team, description: 'Find a Team with given ID', null: true do
    argument :id, ID, required: true
  end

  field :teams, [Types::Team], description: 'List teams in which current user is a member', null: false

  field :authentication_salt, String, description: 'Get authentication salt for an email', null: false do
    argument :email, String, required: true
  end

  field :incoming_invitations, [Types::IncomingInvitation], null: false

  def authentication_salt(email:)
    AuthenticationSaltProxyService.new(email).salt
  end

  def team(id:)
    TeamsResolver.new(context).member(id)
  end

  def teams
    TeamsResolver.new(context).collection
  end

  def session
    context[:current_session]
  end

  def sessions
    SessionsResolver.new(context).collection
  end

  def incoming_invitations
    InvitationsResolver.new(context).incoming.includes(:team, :inviting_user)
  end
end
