Types::UserType = GraphQL::ObjectType.define do
  name "User"
  field :id, !types.ID
  field :email, !types.String
  field :authentication_salt, !types.String
  field :name, types.String
  field :encryption_salt, types.String
end
