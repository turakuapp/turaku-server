module V0
  class TagsController < ApiController
    # GET /api/v0/tags
    def index
      team = Team.find(params[:team_id])
      authorize [:v0, Tag.new(team: team)]
      @tags = team.tags
    end
  end
end
