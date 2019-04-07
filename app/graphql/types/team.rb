class Types::Team < Types::BaseObject
  field :id, ID, null: false
  field :name, String, null: false
  field :encrypted_password, Types::EncryptedData, null: false
  field :entries, [Types::Entry], null: false
  field :team_members, [Types::TeamMember], null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :invitations, [Types::OutgoingInvitation], null: false
  field :tags, [Types::Tag], null: false

  def entries
    # Preload tags for each entry.
    object.entries.includes(:tags, :user)
  end

  def team_members
    object.users
  end

  def encrypted_password
    object.team_memberships.find_by(user: context[:current_user]).encrypted_password
  end

  def invitations
    InvitationsResolver.new(context).outgoing(object).includes(:invited_user, :inviting_user)
  end
end
