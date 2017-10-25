module Users
  class CreateTeamService
    def initialize(user, name, encrypted_password)
      @user = user
      @name = name
      @encrypted_password = encrypted_password
    end

    # @return [Team] Newly created Team
    def create
      Team.transaction do
        team = Team.create!(name: @name)
        TeamMembership.create!(team: team, user: @user, encrypted_password: @encrypted_password)
        team
      end
    end
  end
end
