module Entries
  class UpdateForm < Reform::Form
    include TagsExistenceValidatable

    property :encrypted_data, validates: { encrypted_object: true }
    property :tag_ids

    def save
      Entries::UpdateService.new(model, encrypted_data, tags).update
    end

    private

    def team
      model.team
    end
  end
end
