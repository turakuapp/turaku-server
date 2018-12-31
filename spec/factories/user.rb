FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password { 'password' }

    trait(:registered) do
      sequence(:authentication_salt) { |i| Digest::SHA2.hexdigest(i.to_s) }
    end

    trait(:confirmed) do
      registered
      confirmed_at { Time.zone.now }
    end
  end
end
