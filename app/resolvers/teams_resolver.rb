class TeamsResolver < ApplicationResolver
  def member(id)
    collection.find_by(id: id)
  end

  def collection
    return Team.none if current_user.blank?

    current_user.teams
  end
end
