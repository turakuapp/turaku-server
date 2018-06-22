module Invitations
  class AcceptForm < Reform::Form
    property :encrypted_password, virtual: true, validates: { encrypted_object: true }

    validate :accept_only_once

    def accept_only_once
      return if model.accepted_at.blank?
      errors[:base] << 'AlreadyAcceptedInvitation'
    end

    def save
      Invitations::AcceptService.new(model, encrypted_password).execute
    end
  end
end
