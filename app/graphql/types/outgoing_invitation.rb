class Types::OutgoingInvitation < Types::BaseObject
  field :id, ID, null: false
  field :inviting_user_id, ID, null: false
  field :invited_user, Types::InvitedUser, null: false
  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
end
