class Mutations::AcceptInvitation < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description 'Accept an incoming invitation to join a team.'

  field :invitation, Types::Invitation, null: true
  field :errors, [Types::AcceptInvitationError], null: false

  def resolve(params)
    mutator = Invitations::AcceptInvitationMutator.new(params, context)

    if mutator.valid?
      { invitation: mutator.mutate, errors: [] }
    else
      { invitation: nil, errors: mutator.errors }
    end
  end
end
