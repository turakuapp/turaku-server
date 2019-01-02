class CreateEntryMutator < ApplicationMutator
  attr_accessor :team_id
  attr_accessor :encrypted_data
  attr_accessor :tag_ids

  include ::TagsExistenceValidatable

  validates :encrypted_data, encrypted_object: true

  validate :team_must_be_valid

  def team_must_be_valid
    return if team.present?
    errors.add(:base, 'InvalidTeamId')
  end

  def team
    @team ||= current_user.teams.find_by(id: team_id)
  end

  def create_entry
    Entries::CreateService.new(
      context[:current_user],
      team,
      encrypted_data,
      tags
    ).create
  end
end
