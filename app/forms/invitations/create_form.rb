module Invitations
  class CreateForm < Reform::Form
    property :email, virtual: true, validates: { presence: true, email: true }

    def save
      Users::InviteService.new(model.inviting_user, model.team, email).invite
    end
  end
end
