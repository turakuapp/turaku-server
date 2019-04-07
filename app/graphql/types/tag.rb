class Types::Tag < Types::BaseObject
  field :id, ID, null: false
  field :encrypted_name, Types::EncryptedData, null: false
  field :name_hash, String, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
end
