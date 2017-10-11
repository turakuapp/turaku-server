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

    # GET /api/v0/teams/:id/users
    def users
      @team = current_user.teams.find(params[:id])
    end

    # POST /api/v0/teams/:id/invite?invite_params
    def invite
      team = current_user.teams.find(params[:id])

      authorize [:v0, team]

      form = Users::InviteForm.new(User.new)

      unless form.validate(invite_params)
        raise ValidationFailureException, form.errors
      end

      @invitation = form.save(current_user, team)
    end

    private

    def create_params
      params.require(:team).permit(:name)
    end

    def invite_params
      params.require(:user).permit(:email)
    end
  end
end
