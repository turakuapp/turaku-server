module Teams
  class CreateForm < Reform::Form
    property :name, validates: { presence: true, length: { minimum: 3, maximum: 100 } }
    property :encrypted_password, virtual: true, validates: { encrypted_object: true }

    def save(current_user)
      Users::CreateTeamService.new(current_user, name, encrypted_password).create
    end
  end
end
