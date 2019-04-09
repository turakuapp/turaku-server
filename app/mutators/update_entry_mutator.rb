class UpdateEntryMutator < ApplicationMutator
  attr_accessor :id
  attr_accessor :encrypted_data
  attr_accessor :tag_ids

  include ::TagsExistenceValidatable

  validates :encrypted_data, encrypted_object: true

  validate :entry_must_be_accessible

  def entry
    @entry ||= Entry.joins(:team).where(team: current_user.teams).find_by(id: id)
  end

  def update_entry
    Entries::UpdateService.new(entry, encrypted_data, tags).update
  end

  def authorize
    return if current_user.present? && entry.present?

    raise UnauthorizedMutationException
  end
end
