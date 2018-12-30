FactoryBot.define do
  factory :team do
    name { Faker::Lorem.words(2).join(' ') }
  end
end
