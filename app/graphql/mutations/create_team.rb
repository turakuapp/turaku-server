class Mutations::CreateTeam < GraphQL::Schema::Mutation
  argument :name, String, required: true
  argument :encrypted_password, Types::EncryptedDataInput, required: true

  description "Create a new team."

  field :team, Types::Team, null: true
  field :errors, [String], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params)
    form = Teams::CreateForm.new(Team.new)

    if form.validate(params)
      team = form.save(context[:current_user])

      { team: team, errors: [] }
    else
      { team: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
