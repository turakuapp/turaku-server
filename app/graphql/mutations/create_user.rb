class Mutations::CreateUser < GraphQL::Schema::Mutation
  # Arguments.
  argument :name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true
  argument :authentication_salt, String, required: true

  description "Register as a new user. The supplied authentication salt must be generated client-side and used to salt and hash the password supplied by the user."

  field :user, Types::User, null: true
  field :errors, [String], null: false

  def resolve(params)
    registration_form = Users::RegistrationForm.new(User.new)

    if registration_form.validate(params)
      { user: registration_form.save, errors: [] }
    else
      { user: nil, errors: registration_form.errors.messages.values.flatten }
    end
  end
end
