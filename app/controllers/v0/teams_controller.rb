module V0
  class TeamsController < ApiController
    # POST /api/v0/teams?create_params
    def create
      form = Teams::CreateForm.new(Team.new)

      unless form.validate(create_params)
        raise ValidationFailureException, form.errors
      end

      @team = form.save(current_user)
    end

    # GET /api/v0/teams/:id/entries
    def entries
      team = current_user.teams.find(params[:id])
      @entries = team.entries
    end

    # GET /api/v0/teams/:id/users
    def users
      team = current_user.teams.find(params[:id])

      @users = team.users
      @invited_users = team.invited_users.merge(Invitation.pending)
    end

    private

    def create_params
      params.require(:team).permit(:name, encrypted_password: {})
    end
  end
end
