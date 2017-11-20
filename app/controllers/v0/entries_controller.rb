module V0
  class EntriesController < ApiController
    # POST /api/v0/entries?create_params
    def create
      raise Pundit::NotAuthorizedError unless EntryPolicy.new(current_user, :entry).create?(create_params[:team_id])

      form = Entries::CreateForm.new(Entry.new)

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
      params.require(:entry).permit(:team_id, encrypted_data: {})
    end

    def update_params
      params.require(:entry).permit(encrypted_data: {})
    end
  end
end
