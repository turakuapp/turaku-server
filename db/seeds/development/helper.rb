class Seed
  class << self
    # TODO: Seed.hash_password uses SHA256 for hashing. Replace with PBKDF2 or better.
    def hash_password(secret)
      authentication_salt = SecureRandom.hex(32)
      encryption_salt = SecureRandom.hex(32)

      {
        password: Digest::SHA2.base64digest(secret + authentication_salt),
        authentication_salt: authentication_salt,
        encryption_salt: encryption_salt
      }
    end

    # TODO: Seed.encrypted_password uses SHA256 for hashing. Replace with PBKDF2 or better.
    def encrypted_team_password(user, password)
      # Create a random 256-bit password as the shared password for team.
      team_password = SecureRandom.base64(32)

      # Create a key to encrypt the team password (INSECURE) by hashing the user's password with the encryption salt.
      encryption_hash = Digest::SHA2.base64digest(password + user.encryption_salt)

      # Encrypt the team password with the key and a random IV.
      encrypt(encryption_hash, team_password)
    end

    def encrypt(base64_key, data_string)
      cipher = OpenSSL::Cipher.new 'AES-256-CBC'
      cipher.encrypt
      iv = cipher.random_iv
      cipher.key = Base64.strict_decode64(base64_key)
      encrypted = cipher.update(data_string) + cipher.final

      {
        ciphertext: Base64.strict_encode64(encrypted),
        iv: Base64.strict_encode64(iv)
      }
    end

    def decrypt(base64_key, encrypted_data_hash)
      decipher = OpenSSL::Cipher.new 'AES-256-CBC'
      decipher.decrypt
      decipher.iv = Base64.strict_decode64(encrypted_data_hash['iv'])
      decipher.key = Base64.strict_decode64(base64_key)
      raw_ciphertext = Base64.strict_decode64(encrypted_data_hash['ciphertext'])
      decipher.update(raw_ciphertext) + decipher.final
    end

    def encryptData(user, team, password, data)
      # Create the encryption hash.
      encryption_hash = Digest::SHA2.base64digest(password + user.encryption_salt)

      # Decrypt the team password for the user.
      encrypted_team_password = user.team_memberships.find_by(team: team).encrypted_password
      team_password = decrypt(encryption_hash, encrypted_team_password)

      # Encrypt the data using team password.
      encrypt(team_password, data)
    end
  end
end
