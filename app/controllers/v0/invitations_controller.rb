module V0
  class InvitationsController < ApplicationController
    # POST /api/v0/invitations?create_params
    def create
      invitation = Invitation.new(
        inviting_user: current_user,
        team: current_user.teams.find(create_params[:team_id])
      )

      authorize [:v0, invitation]

      form = Invitations::CreateForm.new(invitation)

      unless form.validate(create_params)
        raise ValidationFailureException, form.errors
      end

      @invitation = form.save
    end

    # DELETE /api/v0/invitations/:id
    def destroy
      @invitation = Invitation.find(params[:id])

      authorize [:v0, @invitation]

      @invitation.destroy!
    end

    # POST /api/v0/invitations/:id/accept
    def accept
      @invitation = Invitation.find(params[:id])

      authorize [:v0, @invitation]

      Invitations::AcceptService.new(@invitation).execute

      # TODO: This should probably return the same data as when a team is chosen from the list.
    end

    private

    def create_params
      params.require(:invitation).permit(:team_id, :email)
    end
  end
end
