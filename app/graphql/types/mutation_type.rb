class Types::MutationType < Types::BaseObject
  field :create_user, mutation: Mutations::CreateUser, null: false
  field :create_session, mutation: Mutations::CreateSession, null: false
  field :delete_session, mutation: Mutations::DeleteSession, null: false
  field :create_team, mutation: Mutations::CreateTeam, null: false
  field :create_invitation, mutation: Mutations::CreateInvitation, null: false
  field :delete_invitation, mutation: Mutations::DeleteInvitation, null: false
  field :accept_invitation, mutation: Mutations::AcceptInvitation, null: false
  field :create_entry, mutation: Mutations::CreateEntry, null: false
  field :update_entry, mutation: Mutations::UpdateEntry, null: false
  field :create_tag, mutation: Mutations::CreateTag, null: false
end
