class Session < ApplicationRecord
  belongs_to :user

  # Holds the non-hashed token temporarily.
  attr_writer :token

  # Return the hashed token if true token isn't available.
  def token
    @token.present? ? @token : token_hash
  end
end
