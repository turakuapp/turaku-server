module V0
  class TeamsController < ApiController
    # POST /api/v0/teams?create_params
    def create
      form = Teams::CreateForm.new(Team.new)

      unless form.validate(create_params)
        raise ValidationFailureException, form.errors
      end

      @team = Users::CreateTeamService.new(current_user, create_params).create
    end

    private

    def create_params
      params.require(:team).permit(:name)
    end
  end
end
