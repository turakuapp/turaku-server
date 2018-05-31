class Types::EncryptedData < Types::BaseObject
  field :iv, String, null: false
  field :ciphertext, String, null: false
end
