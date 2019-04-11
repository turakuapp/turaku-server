class Mutations::CreateSession < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  description "Create a new session for a user. The supplied password must have been salted and hashed with the user's authentication salt."

  field :session, Types::Session, null: true
  field :teams, [Types::Team], null: false
  field :incomingInvitations, [Types::IncomingInvitation], null: false
  field :errors, [Types::CreateSessionError], null: false

  def resolve(params)
    mutator = CreateSessionMutator.new(params, context)

    if mutator.valid?
      session = mutator.create_session

      # Update the context now that the user has signed in.
      context[:current_user] = session.user

      {
        session: session,
        teams: session.user.teams,
        incoming_invitations: session.user.incoming_invitations,
        errors: []
      }
    else
      {
        session: nil,
        teams: [],
        incoming_invitations: [],
        errors: mutator.error_codes
      }
    end
  end
end
