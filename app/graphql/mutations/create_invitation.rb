class Mutations::CreateInvitation < GraphQL::Schema::Mutation
  argument :team_id, ID, required: true
  argument :email, String, required: true

  description "Invite a new user to one of current user's teams. The new user will need to sign up / sign in and accept the request."

  field :invitation, Types::Invitation, null: true
  field :errors, [String], null: false

  def resolve(params)
    invitation = Invitation.new(inviting_user: context[:current_user])
    form = Invitations::CreateForm.new(invitation)

    if form.validate(params)
      { invitation: form.save, errors: [] }
    else
      { invitation: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
