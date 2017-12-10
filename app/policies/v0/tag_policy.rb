module V0
  class TagPolicy < ApplicationPolicy
    def index?
      user.teams.include?(record.team)
    end
  end
end
