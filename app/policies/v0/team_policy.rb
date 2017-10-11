module V0
  class TeamPolicy < ApplicationPolicy
    def invite?
      true
    end
  end
end
