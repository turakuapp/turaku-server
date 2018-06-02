require_relative 'helper'

puts "Seeding users..."

hash = Seed.hash_password("password")

User.create!(
  name: "John Doe",
  email: "johndoe@example.com",
  password: hash[:password],
  authentication_salt: hash[:authentication_salt],
  encryption_salt: hash[:encryption_salt],
  confirmed_at: Time.zone.now
)
