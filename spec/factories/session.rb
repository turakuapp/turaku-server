FactoryBot.define do
  factory :session do
    user
    sequence(:token_hash) { |i| Digest::SHA256.hexdigest("TOKEN_#{i}") }

    before(:create) do |session|
      if session.token.present?
        session.token_hash = Digest::SHA256.hexdigest(session.token)
      end
    end
  end
end
