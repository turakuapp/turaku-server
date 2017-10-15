module V0
  class InvitationPolicy < ApplicationPolicy
    # TODO: Only admins in a team can invite others.
    def create?
      # Any user with a team can invite.
      user.teams.any?
    end

    # TODO: Only admins from inviting team should be able to delete an invitation.
    def destroy?
      # Invited user, and anyone from inviting team can delete an invitation.
      accept? || user.teams.find_by(team: record.team).present?
    end

    def accept?
      # Is the current user the one being invited?
      user.incoming_invitations.find_by(id: record.id).present?
    end
  end
end
