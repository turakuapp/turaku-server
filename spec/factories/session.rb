FactoryBot.define do
  factory :session do
    user
    sequence(:token) { |i| "TOKEN_#{i}" }
    token_hash { Digest::SHA256.hexdigest(token) }
  end
end
