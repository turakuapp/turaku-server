module Tags
  class CreateForm < Reform::Form
    property :team_id, validates: { presence: true }
    property :encrypted_name, validates: { encrypted_object: true }
    property :name_hash, validates: { presence: true }

    def save
      return tag if tag.present?
      @created = true
      Tags::CreateService.new(team, encrypted_name, name_hash).create
    end

    def created?
      !!@created
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
