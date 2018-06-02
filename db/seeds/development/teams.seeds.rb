require_relative 'helper'

after "development:users" do
  puts "Seeding teams..."

  john = User.find_by(email: "johndoe@example.com")

  # Create team, and set enc
  team = john.teams.create!(name: "Hunters Inc.")
  TeamMembership.find_by(team: team, user: john).update!(encrypted_password: Seed.encrypted_password(john.encryption_salt))
end
