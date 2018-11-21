class Types::CreateSessionError < Types::BaseEnum
  value 'InvalidEmail', 'Supplied email does not look like a valid email address'
  value 'AuthenticationFailure', 'Supplied email and password does not match any existing user'
  value 'UnconfirmedEmail', 'Supplied email has not been confirmed by the user'
end
