class Mutations::DeleteSession < GraphQL::Schema::Mutation
  argument :id, ID, required: false

  description "Deletes a session. If sent without session ID, it'll delete the currently active session. Deleting a session disables the related access token."

  field :errors, [String], null: false

  def resolve(params)
    destroy_session_form = Sessions::DestroyForm.new(Session.new)
    destroy_session_form.current_session = context[:current_session]

    if destroy_session_form.validate(params)
      destroy_session_form.destroy
      { errors: [] }
    else
      { errors: destroy_session_form.errors.messages.values.flatten }
    end
  end
end
