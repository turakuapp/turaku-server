class Mutations::AcceptInvitation < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description 'Accept an incoming invitation to join a team.'

  field :invitation, Types::IncomingInvitation, null: true
  field :team, Types::Team, null: true
  field :errors, [Types::AcceptInvitationError], null: false

  def resolve(params)
    mutator = AcceptInvitationMutator.new(params, context)

    if mutator.valid?
      invitation = mutator.accept_invitation
      { invitation: invitation, team: invitation.team, errors: [] }
    else
      { invitation: nil, team: nil, errors: mutator.error_codes }
    end
  end
end
