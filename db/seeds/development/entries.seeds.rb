require_relative 'helper'

after 'development:teams' do
  puts 'Seeding entries...'

  john = User.find_by(email: 'johndoe@example.com')

  entry_data = {
    title: "Sample Entry #1",
    fields: [
      { kind: 'text', key: 'URL', value: 'https://example.com' },
      { kind: 'password', key: 'Password', value: 'let me in' }
    ]
  }

  team = john.teams.first

  Entry.create!(
    user: john,
    team: team,
    encrypted_data: Seed.encryptData(john, team, 'password', entry_data.to_json)
  )
end
