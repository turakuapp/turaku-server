module V0
  class TagPolicy < ApplicationPolicy
    def index?
      user.teams.include?(record.team)
    end

    def create?
      index?
    end
  end
end
