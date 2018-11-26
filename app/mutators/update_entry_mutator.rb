class UpdateEntryMutator < ApplicationMutator
  attr_accessor :id
  attr_accessor :encrypted_data
  attr_accessor :tag_ids

  include ::TagsExistenceValidatable

  validates :encrypted_data, encrypted_object: true

  validate :entry_must_be_accessible

  def entry_must_be_accessible
    return if entry.present?
    errors.add(:base, 'InvalidId')
  end

  def entry
    @entry ||= begin
      Entry.joins(:teams).where(team: context[:current_user].teams).find_by(id: id)
    end
  end

  def update_entry
    Entries::UpdateService.new(model, encrypted_data, tags).update
  end
end
