class Mutations::CreateEntry < Mutations::BaseMutation
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
    team = current_user.teams.find(params[:team_id])
    entry = Entry.new(team: team)
    form = Entries::CreateForm.new(entry)

    if form.validate(params)
      { entry: form.save(current_user), errors: [] }
    else
      { entry: nil, errors: form.errors.messages.values.flatten }
    end
  end
end
