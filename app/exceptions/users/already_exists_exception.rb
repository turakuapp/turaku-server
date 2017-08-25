module Users
  class AlreadyExistsException < ApplicationException
    def reason
      'There is a user associated with this email address. Please sign in instead of attempting to register again.'
    end
  end
end
