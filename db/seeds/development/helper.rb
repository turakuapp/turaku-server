class Seed
  # TODO: Seed.hash_password uses SHA256 for hashing. Replace with PBKDF2 or better.
  def self.hash_password(secret)
    authentication_salt = SecureRandom.hex(32)
    encryption_salt = SecureRandom.hex(32)

    {
      password: Digest::SHA2.base64digest(secret + authentication_salt),
      authentication_salt: authentication_salt,
      encryption_salt: encryption_salt
    }
  end

  # TODO: Seed.encrypted_password uses SHA256 for hashing. Replace with PBKDF2 or better.
  def self.encrypted_password(encryption_salt)
    # Create a random 256-bit password as the shared password for team.
    password = SecureRandom.base64(32)

    # Create a key to encrypt the team password (INSECURE) by hashing the user's password with the encryption salt.
    key = Digest::SHA2.base64digest("password#{encryption_salt}")

    # Encrypt the team password with the key and a random IV.
    cipher = OpenSSL::Cipher.new 'AES-256-CBC'
    cipher.encrypt
    iv = cipher.random_iv
    cipher.key= Base64.strict_decode64(key)
    encrypted = cipher.update(password) + cipher.final

    {
      ciphertext: Base64.strict_encode64(encrypted),
      iv: Base64.strict_encode64(iv)
    }
  end
end
