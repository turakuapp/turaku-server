class Types::AcceptInvitationError < Types::BaseEnum
  value 'BlankInvitationId', 'Supplied invitation ID was blank'
  value 'InvalidInvitationId', 'Invitation with the supplied ID could not be found'
  value 'AlreadyAcceptedInvitation', 'Invitation has already been accepted'
  value 'InvalidEncryptedObject', 'Supplied encrypted object is invalid'
end
