class InvitationsResolver < ApplicationResolver
  def incoming
    return Invitation.none if current_user.blank?

    current_user.incoming_invitations.pending
  end

  def outgoing(team)
    # TODO: Return Team.none if current_user is not someone who can manage invitations to a team.
    team.invitations.pending
  end
end
