class Mutations::CreateInvitation < GraphQL::Schema::Mutation
  argument :team_id, ID, required: true
  argument :email, String, required: true

  description "Invite a new user to one of current user's teams. The new user will need to sign up / sign in and accept the request."

  field :invitation, Types::Invitation, null: true
  field :errors, [String], null: false

  def resolve(params)
    mutator = CreateInvitationMutator.new(params, context)

    if mutator.valid?
      { invitation: mutator.create_invitation, errors: [] }
    else
      { invitation: nil, errors: mutator.error_codes }
    end
  end
end
