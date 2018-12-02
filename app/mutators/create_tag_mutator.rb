class CreateTagMutator < ApplicationMutator
  attr_accessor :team_id
  attr_accessor :name_hash
  attr_accessor :encrypted_name

  validates :encrypted_name, encrypted_object: true

  validate :team_must_be_present

  def team_must_be_present
    return if team.present?
    errors.add(:base, 'InvalidTeamId')
  end

  def tag
    @tag ||= team.tags.find_by(name_hash: name_hash)
  end

  def team
    @team ||= current_user.teams.find_by(id: team_id)
  end

  def create_tag
    return tag if tag.present?

    Tags::CreateService.new(team, encrypted_name.to_h, name_hash).create
  end
end
