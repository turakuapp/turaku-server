class Types::IncomingInvitation < Types::BaseObject
  field :id, ID, null: false
  field :team_name, String, null: false
  field :inviting_user, Types::InvitingUser, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false

  def team_name
    object.team.name
  end
end
