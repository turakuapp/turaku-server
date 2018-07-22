require_relative 'helper'

after 'development:teams' do
  puts 'Seeding tags...'

  john = User.find_by(email: 'johndoe@example.com')
  team = john.teams.first

  ['Social Media', 'Email', 'Temporary', 'Engineering', 'Sales & Marketing'].each do |tag_name|
    Tag.create!(
      team: team,
      encrypted_name: Seed.encryptData(john, team, 'password', tag_name),
      name_hash: Digest::SHA2.base64digest(tag_name.upcase)
    )
  end
end
