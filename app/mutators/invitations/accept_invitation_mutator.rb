module Invitations
  class AcceptInvitationMutator < ApplicationMutator
    attr_accessor :id
    attr_accessor :encrypted_password

    validate :id, presence: { message: 'BlankInvitationId' }
    validate :encyrpted_password, encrypted_object: true

    validate :invitation_must_belong_to_user
    validate :accept_only_once

    def invitation_must_belong_to_user
      return if invitation.present?
      errors[:base] << 'InvalidInvitationId'
    end

    def accept_only_once
      return if model.accepted_at.blank?
      errors[:base] << 'AlreadyAcceptedInvitation'
    end

    # @return [Invitation] Invitation that has been accepted.
    def mutate
      Invitation.transaction do
        # Add invited user to the team.
        TeamMembership.create!(
          team: invitation.team,
          user: invitation.invited_user,
          encrypted_password: encrypted_password.to_h
        )

        # Mark the invitation as having been accepted.
        invitation.update!(accepted_at: Time.zone.now)

        invitation
      end
    end

    def invitation
      @invitation ||= context[:current_user].invitations.find_by(id: id)
    end
  end
end
