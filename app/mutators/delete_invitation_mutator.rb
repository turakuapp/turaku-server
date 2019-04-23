class DeleteInvitationMutator < ApplicationMutator
  attr_accessor :id

  # Supplied ID should be of an invitation to the current user, or an invitation from one of the current user's teams.
  def invitation
    @invitation ||= begin
      current_user.incoming_invitations.find_by(id: id) ||
        Invitation.where(team: context[:current_user].teams).find_by(id: id)
    end
  end

  def delete_invitation
    invitation.destroy!
  end

  def authorize
    return if current_user.present? && invitation.present?

    raise UnauthorizedMutationException
  end
end
