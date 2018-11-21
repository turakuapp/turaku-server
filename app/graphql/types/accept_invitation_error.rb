class Types::AcceptInvitationError < Types::BaseEnum
  value 'InvalidInvitationId', 'Invitation with the supplied ID could not be found'
  value 'AlreadyAcceptedInvitation', 'Invitation has already been accepted'
  value 'InvalidEncryptedObject', 'Supplied encrypted object is invalid'
end
