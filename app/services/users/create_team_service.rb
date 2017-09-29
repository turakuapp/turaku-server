module Users
  class CreateTeamService
    def initialize(user, params)
      @user = user
      @params = params
    end

    # @return [Team] Newly created Team
    def create
      @user.teams.create!(name: @params[:name])
    end
  end
end
