module Invitations
  class AcceptService
    def initialize(invitation)
      @invitation = invitation
    end

    def execute
      raise Invitations::AlreadyAcceptedException if @invitation.accepted_at.present?

      Invitation.transaction do
        # Add invited user to the team.
        team = @invitation.team
        team.users << @invitation.invited_user
        team.save!

        # Mark the invitation as having been accepted.
        @invitation.update!(accepted_at: Time.zone.now)
      end
    end
  end
end
