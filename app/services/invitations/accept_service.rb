module Invitations
  class AcceptService
    def initialize(invitation, encrypted_password)
      @invitation = invitation
      @encrypted_password = encrypted_password
    end

    def execute
      raise Invitations::AlreadyAcceptedException if @invitation.accepted_at.present?

      Invitation.transaction do
        # Add invited user to the team.
        TeamMembership.create!(
          team: @invitation.team,
          user: @invitation.invited_user,
          encrypted_password: @encrypted_password
        )

        # Mark the invitation as having been accepted.
        @invitation.update!(accepted_at: Time.zone.now)
      end
    end
  end
end
