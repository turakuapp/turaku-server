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

      user = User.create!(name: @name, email: @email, password: @password, authentication_salt: @authentication_salt)
      user.send_confirmation_instructions
      user
    end
  end
end
