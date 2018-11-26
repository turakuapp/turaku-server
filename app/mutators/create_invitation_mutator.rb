class CreateInvitationMutator < ApplicationMutator
  attr_accessor :team_id
  attr_accessor :email

  validates :email, email: true

  validate :team_must_be_valid
  validate :invite_only_once

  def team_must_be_valid
    return if team.present?
    errors.add(:base, 'InvalidTeamId')
  end

  def invite_only_once
    return if user.blank?
    return if user.incoming_invitations.find_by(team: team).blank?
    errors.add(:base, 'UserAlreadyInvited')
  end

  def team
    @team ||= current_user.teams.find_by(id: team_id)
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def create_invitation
    Users::InviteService.new(current_user, team, email).invite
  end
end
