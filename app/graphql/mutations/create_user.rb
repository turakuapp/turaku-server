Mutations::CreateUser = GraphQL::Relay::Mutation.define do
  name "CreateUser"

  # Return fields.
  return_type Types::UserType

  # Arguments.
  input_field :name, !types.String
  input_field :email, !types.String
  input_field :password, !types.String
  input_field :authentication_salt, !types.String

  resolve ->(_obj, args, _ctx) {
    Users::CreateService.new(args[:name], args[:email], args[:password], args[:authentication_salt]).create
  }
end
