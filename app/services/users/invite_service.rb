module Users
  # Invites a given email address to join a team.
  class InviteService
    def initialize(inviting_user, team, email)
      @inviting_user = inviting_user
      @team = team
      @email = email
    end

    # @return [Invitation] Invitation for invited user.
    def invite
      Invitation.transaction do
        user = User.where(email: @email).first_or_create!(skip_password: true)

        raise Users::AlreadyInvitedException if user.incoming_invitations.find_by(team: @team).present?

        invitation = Invitation.create!(invited_user: user, inviting_user: @inviting_user, team: @team)

        UserMailer.invite(user, @inviting_user, @team).deliver_later

        invitation
      end
    end
  end
end
