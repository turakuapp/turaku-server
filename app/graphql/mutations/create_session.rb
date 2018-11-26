class Mutations::CreateSession < Mutations::BaseMutation
  argument :email, String, required: true
  argument :password, String, required: true

  description "Create a new session for a user. The supplied password must have been salted and hashed with the user's authentication salt."

  field :session, Types::Session, null: true
  field :errors, [Types::CreateSessionError], null: false

  def resolve(params)
    mutator = CreateSessionMutator.new(params, context)

    if mutator.valid?
      session = mutator.create_session

      # Update the context now that the user has signed in.
      context[:current_user] = session.user

      { session: session, errors: [] }
    else
      { session: nil, errors: mutator.error_codes }
    end
  end
end
