after 'development:users' do
  puts 'Seeding sessions...'

  john = User.find_by(email: 'johndoe@example.com')
  token = SecureRandom.uuid
  token_hash = Sessions::TokenHashService.new(token).hash
  john.sessions.create!(user: @user, last_used_at: Time.zone.now, token_hash: token_hash)

  puts "Use header 'Authorization: #{token}' to connect to GraphQL as johndoe@example.com."
end
