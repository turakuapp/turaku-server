module V0
  class EntryPolicy < ApplicationPolicy
    def create?
      record.team.users.include?(user)
    end

    def update?
      record.team.in?(user.teams)
    end
  end
end
