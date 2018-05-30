module Users
  class CreateService
    def initialize(name, email, password, authentication_salt)
      @name = name
      @email = email
      @password = password
      @authentication_salt = authentication_salt
    end

    def create
      User.create!(
        name: @name,
        email: @email,
        password: @password,
        authentication_salt: @authentication_salt,
        encryption_salt: encryption_salt
      )
    end

    private

    def user
      @user ||= User.find_by(email: @email)
    end

    def encryption_salt
      SecureRandom.hex(32)
    end
  end
end
