class Types::MutationType < Types::BaseObject
  field :create_user, mutation: Mutations::CreateUser, null: false
end
