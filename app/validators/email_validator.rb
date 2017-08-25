class EmailValidator < ActiveModel::EachValidator
  REGULAR_EXPRESSION = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  def validate_each(record, attribute, value)
    return if REGULAR_EXPRESSION.match?(value)
    record.errors[attribute] << 'does not look like an email address'
  end
end
