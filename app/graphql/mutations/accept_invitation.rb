class Mutations::AcceptInvitation < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description 'Accept an incoming invitation to join a team.'

  field :invitation, Types::Invitation, null: true
  field :errors, [Types::AcceptInvitationError], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params)
    mutator = AcceptInvitationMutator.new(params, context)

    if mutator.valid?
      { invitation: mutator.accept_invitation, errors: [] }
    else
      { invitation: nil, errors: mutator.error_codes }
    end
  end
end
