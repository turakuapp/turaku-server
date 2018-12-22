class AcceptInvitationMutator < ApplicationMutator
  attr_accessor :id
  attr_accessor :encrypted_password

  validates :encrypted_password, encrypted_object: true

  validate :invitation_must_belong_to_user
  validate :accept_only_once

  def invitation_must_belong_to_user
    return if invitation.present?

    errors.add(:base, 'InvalidId')
  end

  def accept_only_once
    return if invitation.accepted_at.blank?

    errors.add(:base,'AlreadyAcceptedInvitation')
  end

  # @return [Invitation] Invitation that has been accepted.
  def accept_invitation
    Invitations::AcceptService.new(invitation, encrypted_password).accept
  end

  def invitation
    @invitation ||= current_user.incoming_invitations.find_by(id: id)
  end
end
