module Invitations
  class AcceptService
    def initialize(invitation, encrypted_password)
      @invitation = invitation
      @encrypted_password = encrypted_password
    end

    def execute
      Invitation.transaction do
        # Add invited user to the team.
        TeamMembership.create!(
          team: @invitation.team,
          user: @invitation.invited_user,
          encrypted_password: @encrypted_password.to_h
        )

        # Mark the invitation as having been accepted.
        @invitation.update!(accepted_at: Time.zone.now)

        @invitation
      end
    end
  end
end
