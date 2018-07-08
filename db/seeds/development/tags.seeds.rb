require_relative 'helper'

after 'development:teams' do
  puts 'Seeding tags...'

  john = User.find_by(email: 'johndoe@example.com')
  team = john.teams.first

  3.times do
    tag_name = Faker::Lorem.word

    Tag.create!(
      team: team,
      encrypted_name: Seed.encryptData(john, team, 'password', tag_name),
      name_hash: Digest::SHA2.base64digest(tag_name)
    )
  end
end
