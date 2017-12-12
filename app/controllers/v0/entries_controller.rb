module V0
  class EntriesController < ApiController
    # POST /api/v0/entries?create_params
    def create
      team = current_user.teams.find(create_params[:team_id])
      entry = Entry.new(team: team)
      authorize [:v0, entry]

      form = Entries::CreateForm.new(entry)

      unless form.validate(create_params)
        raise ValidationFailureException, form.errors
      end

      @entry = form.save(current_user)
    end

    # PATCH /api/v0/entries/:id
    def update
      entry = Entry.find(params[:id])
      authorize [:v0, entry]

      form = Entries::UpdateForm.new(entry)

      unless form.validate(update_params)
        raise ValidationFailureException, form.errors
      end

      @entry = form.save
    end

    private

    def create_params
      params.require(:entry).permit(:team_id, { encrypted_data: {} }, tag_ids: [])
    end

    def update_params
      params.require(:entry).permit({ encrypted_data: {} }, tag_ids: [])
    end
  end
end
