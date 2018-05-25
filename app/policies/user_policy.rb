class UserPolicy < ApplicationPolicy
  def owner?
    record == user
  end
end
