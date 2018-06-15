class Types::Invitation < Types::BaseObject
  field :id, ID, null: false
  field :team, Types::Team, null: false
  field :inviting_user, Types::User, null: false
  field :invited_user, Types::InvitedUser, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
end
