class Mutations::CreateUser < GraphQL::Schema::Mutation
  argument :name, String, required: true
  argument :email, String, required: true
  argument :password, String, required: true
  argument :authentication_salt, String, required: true

  description 'Register as a new user. The supplied authentication salt must be generated client-side and used to salt and hash the password supplied by the user.'

  field :user, Types::User, null: true
  field :errors, [String], null: false

  def resolve(params)
    mutator = CreateUserMutator.new(params, context)

    if mutator.valid?
      { user: mutator.create_user, errors: [] }
    else
      { user: nil, errors: mutator.error_codes }
    end
  end
end
