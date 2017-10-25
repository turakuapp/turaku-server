class EncryptedObjectValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.respond_to?(:key?) && value.key?(:ciphertext) && value.key?(:iv)
    record.errors[attribute] << 'is not a valid encrypted object'
  end
end
