module Entries
  # Creates a new entry.
  class CreateService
    # @param user [User] User for whom to create new session.
    def initialize(user, team, encrypted_data)
      @user = user
      @team = team
      @encrypted_data = encrypted_data
    end

    # @return [Entry] Newly created entry.
    def create
      Entry.create!(
        user: @user,
        team: @team,
        encrypted_data: @encrypted_data
      )
    end
  end
end
