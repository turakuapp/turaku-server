Types::UserType = GraphQL::ObjectType.define do
  name "User"

  field :authentication_salt, !types.String
  field :id, !types.ID
  field :email, !types.String { access :owner }
  field :name, types.String { access :owner }
  field :encryption_salt, types.String { access :owner }
end
