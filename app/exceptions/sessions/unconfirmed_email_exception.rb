module Sessions
  class UnconfirmedEmailException < ApplicationException
    def reason
      'The user is yet to confirm the associated email address. A new session cannot be created until this step is completed.'
    end
  end
end
