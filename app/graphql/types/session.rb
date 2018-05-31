class Types::Session < Types::BaseObject
  field :id, ID, null: false
  field :token, String, null: false
  field :user, Types::User, null: false
end
