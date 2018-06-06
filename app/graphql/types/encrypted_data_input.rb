class Types::EncryptedDataInput < Types::BaseInputObject
  description "Encrypted data consists of an initialization vector (IV) and the ciphertext."
  argument :iv, String, required: true
  argument :ciphertext, String, required: true
end
