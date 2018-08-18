class Mutations::CreateSession < GraphQL::Schema::Mutation
  argument :email, String, required: true
  argument :password, String, required: true

  description "Create a new session for a user. The supplied password must have been salted and hashed with the user's authentication salt."

  field :session, Types::Session, null: true
  field :errors, [Types::CreateSessionError], null: false

  def resolve(params)
    sign_in_form = Sessions::SignInForm.new(Session.new)

    if sign_in_form.validate(params)
      session = sign_in_form.save

      # Update the context now that the user has signed in.
      context[:current_user] = session.user

      { session: session, errors: [] }
    else
      { session: nil, errors: sign_in_form.errors.messages.values.flatten }
    end
  end
end
