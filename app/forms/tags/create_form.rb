module Tags
  class CreateForm < Reform::Form
    property :team_id, validates: { presence: true }
    property :encrypted_name, validates: { encrypted_object: true }
    property :name_hash, validates: { presence: true, uniqueness: true }

    def save
      Tags::CreateService.new(Team.find(team_id), encrypted_name, name_hash).create
    end
  end
end
