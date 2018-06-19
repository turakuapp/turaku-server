class Mutations::DeleteInvitation < Mutations::BaseMutation
  argument :id, ID, required: true

  description "Deletes an invitation to one of the user's teams."

  field :errors, [String], null: false

  def resolve(params)
    invitation = Invitation.where(team: current_user.teams).find_by(id: params[:id])

    if invitation.present?
      invitation.destroy!
      { errors: [] }
    else
      { errors: ['InvalidId'] }
    end
  end
end
