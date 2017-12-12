module Tags
  # Creates a new tag.
  class CreateService
    # @param team [Team] Team to which tag will belong.
    # @param encrypted_name [Hash] Name of tag as an encrypted object.
    # @param name_hash [String] Hash of the name, used for duplication checking.
    def initialize(team, encrypted_name, name_hash)
      @team = team
      @encrypted_name = encrypted_name
      @name_hash = name_hash
    end

    # @return [Tag] Newly created tag.
    def create
      Tag.create!(
        team: @team,
        encrypted_name: @encrypted_name,
        name_hash: @name_hash
      )
    end
  end
end
