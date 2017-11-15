module Entries
  class CreateForm < Reform::Form
    property :team_id, validates: { presence: true }
    property :encrypted_data, validates: { encrypted_object: true }

    def save(current_user)
      Entries::CreateService.new(
        current_user,
        Team.find(team_id),
        encrypted_data
      ).create
    end
  end
end
