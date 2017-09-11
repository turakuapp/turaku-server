class ValidationFailureException < ApplicationException
  def initialize(errors)
    @form_errors = errors
  end

  def reason
    "Your submission did not pass validation. See errors: #{@form_errors}"
  end
end
