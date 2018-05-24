Types::UserType = GraphQL::ObjectType.define do
  name "User"

  field :id, !types.ID do
    access :owner
  end

  field :email, !types.String
  field :authentication_salt, !types.String
  field :name, types.String
  field :encryption_salt, types.String
end
