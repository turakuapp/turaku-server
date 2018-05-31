class Types::Team < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :encrypted_password, Types::EncryptedData, null: false

  def encrypted_password
    object.team_memberships.find_by(user: context[:current_user]).encrypted_password
  end
end
