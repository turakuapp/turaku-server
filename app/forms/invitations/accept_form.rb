module Invitations
  class AcceptForm < Reform::Form
    property :encrypted_password, virtual: true, validates: { encrypted_object: true }

    def save
      Invitations::AcceptService.new(model, encrypted_password).execute
    end
  end
end
