module Invitations
  class CreateForm < Reform::Form
    property :email, virtual: true, validates: { presence: { message: "BlankEmail" }, email: true }
    property :team_id, virtual: true, validated: { presence: { message: "BlankTeamId" } }

    validate :user_belongs_to_inviting_team

    def user_belongs_to_inviting_team
      return if team.present?
      errors[:base] << "InvalidTeamId"
    end

    def save
      Users::InviteService.new(model.inviting_user, model.team, email).invite
    end

    private

    def team
      object.inviting_user.teams.find_by(id: team_id)
    end
  end
end
