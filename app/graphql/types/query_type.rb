Types::QueryType = GraphQL::ObjectType.define do
  name "Query"

  field :user do
    type Types::UserType
    argument :email, !types.String
    description "Find a User with email address"
    resolve ->(_obj, args, ctx) do
      User.find_by(email: args[:email])
    end
  end
end
