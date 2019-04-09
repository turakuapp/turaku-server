class Mutations::CreateTeam < GraphQL::Schema::Mutation
  argument :name, String, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description "Create a new team."

  field :team, Types::Team, null: true
  field :errors, [String], null: false

  def resolve(params)
    mutator = CreateTeamMutator.new(params, context)

    if mutator.valid?
      { team: mutator.create_team, errors: [] }
    else
      { team: nil, errors: mutator.error_codes }
    end
  end
end
