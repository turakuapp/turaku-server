require_relative 'helper'

after 'development:teams' do
  puts 'Seeding entries...'

  john = User.find_by(email: 'johndoe@example.com')
  team = john.teams.first

  def new_fake_entry
    name = Faker::Company.name
    {
      title: name,
      fields: [
        { kind: 'text', key: 'URL', value: Faker::Internet.url(name) },
        { kind: 'password', key: 'Password', value: SecureRandom.alphanumeric(16) }
      ]
    }
  end

  3.times do
    Entry.create!(
      user: john,
      team: team,
      encrypted_data: Seed.encryptData(john, team, 'password', new_fake_entry.to_json)
    )
  end
end
