module Users
  class AlreadyInvitedException < ApplicationException
    def reason
      'This email address has a pending invitation to your team. To send the invitation email again, use the corresponding action.'
    end
  end
end
