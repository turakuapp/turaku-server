class UserMailer < ApplicationMailer
  def invite(invited_user, inviting_user, team)
    @invited_user = invited_user
    @inviting_user = inviting_user
    @team = team

    mail(to: invited_user.email, subject: "You have been invited to join team #{team.name}.")
  end
end
