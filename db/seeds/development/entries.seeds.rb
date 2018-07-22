require_relative 'helper'

after 'development:teams', 'development:tags' do
  puts 'Seeding entries...'

  john = User.find_by(email: 'johndoe@example.com')
  team = john.teams.first

  def new_fake_entry
    Faker::Internet.domain_word
    name = Faker::Internet.domain_name
    {
      title: name.split('.').first.capitalize,
      fields: [
        { kind: 'text', key: 'Username', value: 'johndoe@example.com' },
        { kind: 'password', key: 'Password', value: SecureRandom.alphanumeric(rand(10..16)) },
        { kind: 'text', key: 'URL', value: Faker::Internet.url(name, '') }
      ]
    }
  end

  let all_tags = Tag.all

  50.times do
    Entry.create!(
      user: john,
      team: team,
      encrypted_data: Seed.encryptData(john, team, 'password', new_fake_entry.to_json),
      tags: [all_tags.sample]
    )
  end
end
