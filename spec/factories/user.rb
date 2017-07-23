FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email(name) }
    password 'password'
  end
end
