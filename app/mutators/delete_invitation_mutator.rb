class DeleteInvitationMutator < ApplicationMutator
  attr_accessor :id

  validate :invitation_should_be_valid

  def invitation_should_be_valid
    return if invitation.present?
    errors.add(:base, 'InvalidId')
  end

  # Supplied ID should be of an invitation to the current user, or an invitation from one of the current user's teams.
  def invitation
    @invitation ||= begin
      current_user.incoming_invitations.find_by(id: params[:id]) ||
        Invitation.where(team: context[:current_user].teams).find_by(id: id)
    end
  end

  def delete_invitation
    invitation.destroy!
  end
end
