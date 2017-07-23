class Session < ApplicationRecord
  belongs_to :user

  # Holds the non-hashed token temporarily.
  attr_accessor :token
end
