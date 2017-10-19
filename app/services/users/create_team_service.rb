module Users
  class CreateTeamService
    def initialize(user, params)
      @user = user
      @params = params
    end

    # @return [Team] Newly created Team
    def create
      Team.transaction do
        team = Team.create!(name: @params[:name])
        TeamMembership.create!(team: team, user: @user, encrypted_password: @params[:encrypted_password])
        team
      end
    end
  end
end
