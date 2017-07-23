module Sessions
  class AuthenticationFailureException < ApplicationException
    def reason
      'The supplied email address and password did not match any known user. Please retry with a different set of credentials.'
    end
  end
end
