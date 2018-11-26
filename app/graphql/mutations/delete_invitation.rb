class Mutations::DeleteInvitation < Mutations::BaseMutation
  argument :id, ID, required: true

  description "Deletes an invitation to one of the user's teams."

  field :errors, [String], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params)
    mutator = DeleteInvitationMutator.new(params, context)

    if mutator.valid?
      mutator.delete_invitation
      { errors: [] }
    else
      { errors: mutator.error_codes }
    end
  end
end
