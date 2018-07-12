class Types::TagInput < Types::BaseInputObject
  description "Creating a tag requires the hash of its name and its encrypted form."
  argument :name_hash, String, required: true
  argument :encrypted_name, Types::EncryptedDataInput, required: true
end
