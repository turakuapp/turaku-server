require_relative 'helper'

after 'development:users' do
  puts 'Seeding invitations...'

  jane = User.find_by(email: 'janedoe@example.com')
  john = User.find_by(email: 'johndoe@example.com')
  Invitation.create!(invited_user: jane, inviting_user: john, team: john.teams.first)
end
