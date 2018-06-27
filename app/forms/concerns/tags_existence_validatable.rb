# Used in Tags::CreateForm and Tags::UpdateForm to ensure that only tags that exist for the team in question are passed.
# This module makes the assumption that the 'team' method is available that will return the appropriate team under which
# queries for tags should be scoped.
module TagsExistenceValidatable
  extend ActiveSupport::Concern

  included do
    validate :tags_should_exist
  end

  def tags_should_exist
    return if tag_ids.blank?

    tag_ids.each do |tag_id|
      next if team.tags.find_by(id: tag_id).present?
      errors[:base] << "InvalidTag"
    end
  end

  def tags
    @tags ||= begin
      team.tags.find(tag_ids) if tag_ids.present?
    end
  end

  def team
    model.team
  end
end
