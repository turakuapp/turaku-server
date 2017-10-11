module Users
  class InviteForm < Reform::Form
    property :email, validates: { presence: true, email: true }

    def save(inviting_user, team)
      Users::InviteService.new(inviting_user, team, email).invite
    end
  end
end
