class Mutations::CreateTag < GraphQL::Schema::Mutation
  argument :team_id, ID, required: true
  argument :name_hash, String, required: true
  argument :encrypted_name, Types::EncryptedDataInput, required: true

  description "Create a new tag."

  field :tag, Types::Tag, null: true
  field :errors, [String], null: false

  def resolve(params)
    mutator = CreateTagMutator.new(params, context)

    if mutator.valid?
      { tag: mutator.create_tag, errors: [] }
    else
      { tag: nil, errors: mutator.error_codes }
    end
  end
end
