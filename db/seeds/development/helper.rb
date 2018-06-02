class Seed
  def self.hash_password(secret)
    authentication_salt = SecureRandom.hex(32)
    encryption_salt = SecureRandom.hex(32)

    {
      password: Digest::SHA2.hexdigest(secret + authentication_salt),
      authentication_salt: authentication_salt,
      encryption_salt: encryption_salt
    }
  end
end
