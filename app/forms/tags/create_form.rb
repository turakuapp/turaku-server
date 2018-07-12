module Tags
  class CreateForm < Reform::Form
    property :team_id, validates: { presence: { message: 'TeamIdBlank' } }
    property :encrypted_name, validates: { encrypted_object: true }
    property :name_hash, validates: { presence: { message: 'NameHashBlank' } }

    def save
      return tag if tag.present?
      Tags::CreateService.new(team, encrypted_name.to_h, name_hash).create
    end

    private

    def tag
      @tag ||= team.tags.find_by(name_hash: name_hash)
    end

    def team
      @team ||= Team.find(team_id)
    end
  end
end
