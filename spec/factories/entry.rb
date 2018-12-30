FactoryBot.define do
  factory :entry do
    team
    user
    encrypted_data { EncryptedDataHelper.fake }
  end
end
