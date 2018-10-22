FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password 'password'

    trait(:confirmed) do
      confirmed_at { Time.zone.now }
    end
  end
end
