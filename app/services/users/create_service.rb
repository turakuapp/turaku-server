module Users
  class CreateService
    def initialize(name, email, password, authentication_salt)
      @name = name
      @email = email
      @password = password
      @authentication_salt = authentication_salt
    end

    def create
      # Ensure the user does not exist.
      raise Users::AlreadyExistsException if User.find_by(email: @email).present?

      User.create!(name: @name, email: @email, password: @password, authentication_salt: @authentication_salt)
    end
  end
end
