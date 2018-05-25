Types::MutationType = GraphQL::ObjectType.define do
  name "Mutation"

  field :createUser, Mutations::CreateUser.field
end
