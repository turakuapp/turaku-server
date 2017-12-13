module Entries
  class CreateForm < Reform::Form
    include ::TagsExistenceValidatable

    property :team_id, validates: { presence: true }
    property :encrypted_data, validates: { encrypted_object: true }
    property :tag_ids

    def save(current_user)
      Entries::CreateService.new(
        current_user,
        team,
        encrypted_data,
        tags
      ).create
    end

    private

    def team
      @team ||= Team.find(team_id)
    end
  end
end
