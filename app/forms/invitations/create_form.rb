module Invitations
  class CreateForm < Reform::Form
    property :email, virtual: true, validates: { presence: { message: 'BlankEmail' }, email: true }
    property :team_id, virtual: true, validated: { presence: { message: 'BlankTeamId' } }

    validate :user_belongs_to_inviting_team
    validate :invite_only_once

    def user_belongs_to_inviting_team
      return if team.present?
      errors[:base] << 'InvalidTeamId'
    end

    def invite_only_once
      return if user.blank?
      return if user.incoming_invitations.find_by(team: team).blank?
      errors[:base] << 'UserAlreadyInvited'
    end

    def save
      Users::InviteService.new(model.inviting_user, team, email).invite
    end

    private

    def team
      @team ||= model.inviting_user.teams.find_by(id: team_id)
    end

    def user
      @user ||= User.find_by(email: email)
    end
  end
end
