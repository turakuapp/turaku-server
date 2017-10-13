module Invitations
  class AlreadyAcceptedException
    def reason
      'This invitation has been accepted already.'
    end
  end
end
