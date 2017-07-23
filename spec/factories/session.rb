FactoryGirl.define do
  factory :session do
    user
    sequence(:token_hash) { |i| Digest::SHA256.hexdigest("TOKEN_#{i}") }
  end
end
