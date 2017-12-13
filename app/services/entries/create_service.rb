module Entries
  # Creates a new entry.
  class CreateService
    # @param user [User] User who is creating a new entry.
    # @param team [Team] Team for which entry is being created.
    # @param encrypted_data [Hash] Entry data as an encrypted object.
    # @param tags [Array] List of tags for the entry.
    def initialize(user, team, encrypted_data, tags)
      @user = user
      @team = team
      @encrypted_data = encrypted_data
      @tags = tags || []
    end

    # @return [Entry] Newly created entry.
    def create
      @team.entries.create!(
        user: @user,
        encrypted_data: @encrypted_data,
        tags: @tags
      )
    end
  end
end
