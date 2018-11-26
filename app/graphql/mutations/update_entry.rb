class Mutations::UpdateEntry < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_data, Types::EncryptedDataInput, required: true
  argument :tag_ids, [ID], required: true

  description "Update an entry in one of the user's teams."

  field :entry, Types::Entry, null: true
  field :errors, [String], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params)
    mutator = UpdateEntryMutator.new(params, context)

    if mutator.valid?
      { entry: mutator.update_entry, errors: [] }
    else
      { entry: nil, erros: mutator.error_codes }
    end
  end
end
