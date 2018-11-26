class Mutations::CreateEntry < Mutations::BaseMutation
  include ::TagsExistenceValidatable

  argument :team_id, ID, required: true
  argument :encrypted_data, Types::EncryptedDataInput, required: true
  argument :tag_ids, [ID], required: true

  description "Creates an entry in one of the user's teams."

  field :entry, Types::Entry, null: true
  field :errors, [String], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params)
    mutator = CreateEntryMutator.new(params, context)

    if mutator.valid?
      { entry: mutator.create_entry, errors: [] }
    else
      { entry: nil, errors: mutator.error_codes }
    end
  end
end
