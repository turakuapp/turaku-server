class Types::MutationType < Types::BaseObject
  field :create_user, Mutations::CreateUser.field, null: true
end
