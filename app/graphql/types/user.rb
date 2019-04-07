class Types::User < Types::BaseObject
  field :authentication_salt, String, null: false
  field :id, ID, null: false
  field :email, String, null: false
  field :name, String, null: false
  field :encryption_salt, String, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
end
