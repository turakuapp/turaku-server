class Types::MutationType < Types::BaseObject
  field :create_user, mutation: Mutations::CreateUser, null: false
  field :create_session, mutation: Mutations::CreateSession, null: false
end
