class Mutations::UpdateEntry < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :encrypted_data, Types::EncryptedDataInput, required: true
  argument :tag_ids, [ID], required: true

  description "Update an entry in one of the user's teams."

  field :entry, Types::Entry, null: true
  field :errors, [String], null: false

  def resolve(params)
    entry = Entry.find(params[:id])
    form = Entries::UpdateForm.new(entry)

    if form.validate(params)
      { entry: form.save, errors: [] }
    else
      { entry: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
