class Types::Team < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :encrypted_password, Types::EncryptedData, null: false
  field :entries, [Types::Entry], null: false
  field :users, [Types::User], null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :invitations, [Types::Invitation], null: false

  def encrypted_password
    object.team_memberships.find_by(user: context[:current_user]).encrypted_password
  end

  def invitations
    object.invitations.pending
  end
end
