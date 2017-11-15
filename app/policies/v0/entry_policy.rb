module V0
  class EntryPolicy < ApplicationPolicy
    def create?(team_id)
      team = Team.find_by(id: team_id)
      team.present? && team.users.include?(user)
    end
  end
end
