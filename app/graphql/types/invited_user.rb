class Types::InvitedUser < Types::BaseObject
  field :id, ID, null: false
  field :email, String, null: false
  field :name, String, null: true

  def resolve
   # This should resolve to a User. This type, has fewer fields, however.
  end
end
