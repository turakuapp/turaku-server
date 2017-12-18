module V0
  class TagsController < ApiController
    # GET /api/v0/tags
    def index
      team = Team.find(params[:team_id])
      authorize [:v0, Tag.new(team: team)]
      @tags = team.tags
    end

    # POST /api/v0/tags
    def create
      team = Team.find(create_params[:team_id])
      tag = Tag.new(team: team)
      authorize [:v0, tag]

      form = Tags::CreateForm.new(tag)

      unless form.validate(create_params)
        raise ValidationFailureException, form.errors
      end

      @tag = form.save
      render status: (form.created? ? :created : :ok)
    end

    private

    def create_params
      params.require(:tag).permit(:team_id, :name_hash, encrypted_name: {})
    end
  end
end
