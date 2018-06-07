class Types::MutationType < Types::BaseObject
  field :create_user, mutation: Mutations::CreateUser, null: false
  field :create_session, mutation: Mutations::CreateSession, null: false
  field :delete_session, mutation: Mutations::DeleteSession, null: false
  field :create_team, mutation: Mutations::CreateTeam, null: false
end
