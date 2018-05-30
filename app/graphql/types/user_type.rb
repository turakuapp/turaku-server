class Types::UserType < Types::BaseObject
  field :authentication_salt, String, null: false
  field :id, ID, null: false
  field :email, String, null: false
  field :name, String, null: true
  field :encryption_salt, String, null: true
end
