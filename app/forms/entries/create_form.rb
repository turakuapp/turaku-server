module Entries
  class CreateForm < Reform::Form
    include ::TagsExistenceValidatable

    property :encrypted_data, validates: { encrypted_object: true }
    property :tag_ids

    def save(current_user)
      Entries::CreateService.new(
        current_user,
        model.team,
        encrypted_data,
        tags
      ).create
    end
  end
end
