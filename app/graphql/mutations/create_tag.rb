class Mutations::CreateTag < GraphQL::Schema::Mutation
  argument :team_id, ID, required: true
  argument :name_hash, String, required: true
  argument :encrypted_name, Types::EncryptedDataInput, required: true

  description "Create a new tag."

  field :tag, Types::Tag, null: true
  field :errors, [String], null: false

  def resolve(params)
    form = Tags::CreateForm.new(Tag.new)

    if form.validate(params)
      { tag: form.save, errors: [] }
    else
      { tag: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
