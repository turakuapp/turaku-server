class UserPolicy < ApplicationPolicy
  def owner?
    false
  end
end
