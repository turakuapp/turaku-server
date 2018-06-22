class Mutations::AcceptInvitation < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description "Accept an incoming invitation to join a team."

  field :invitation, Types::Invitation, null: true
  field :errors, [String], null: false

  def resolve(params)
    invitation = current_user.incoming_invitations.find(params[:id])

    form = Invitations::AcceptForm.new(invitation)

    if form.validate(params)
      { invitation: form.save, errors: [] }
    else
      { invitation: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
