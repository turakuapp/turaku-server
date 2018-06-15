class Types::Entry < Types::BaseObject
  field :id, ID, null: false
  field :tags, [Types::Tag], null: false
  field :encrypted_data, Types::EncryptedData, null: false
  field :team, Types::Team, null: false
  field :user, Types::User, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end
