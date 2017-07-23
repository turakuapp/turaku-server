module Sessions
  class TokenAuthenticationFailedException < ApplicationException
    def reason
      'The supplied token could not be matched against any existing session.'
    end
  end
end
