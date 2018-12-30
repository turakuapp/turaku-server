module EncryptedDataHelper
  def self.fake
    {
      iv: SecureRandom.base64,
      ciphertext: SecureRandom.base64
    }
  end
end
