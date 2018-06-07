class Types::Tag < Types::BaseObject
  field :id, ID, null: false
  field :encrypted_name, Types::EncryptedData, null: false
  field :name_hash, String, null: false
  field :team, Types::Team, null: false
  field :entries, [Types::Entry], null: false
  field :created_at, Types::DateTime, null: false
  field :updated_at, Types::DateTime, null: false
end
