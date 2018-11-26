class Mutations::DeleteSession < GraphQL::Schema::Mutation
  argument :id, ID, required: false

  description "Deletes a session. If sent without session ID, it'll delete the currently active session. Deleting a session disables the related access token."

  field :errors, [String], null: false

  def self.accessible?(context)
    context[:current_user].present?
  end

  def resolve(params={})
    mutator = DeleteSessionMutator.new(params, context)

    if mutator.valid?
      mutator.delete_session
      { errors: [] }
    else
      { errors: mutator.error_codes }
    end
  end
end
