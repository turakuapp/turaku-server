module Users
  class CreateService
    def initialize(name, email, password, authentication_salt)
      @name = name
      @email = email
      @password = password
      @authentication_salt = authentication_salt
    end

    def create
      if user.present?
        # This user shouldn't have completed registration.
        raise Users::AlreadyExistsException if user.authentication_salt.present?

        update_existing_user
      else
        create_new_user
      end
    end

    private

    def update_existing_user
      user.update!(
        name: @name,
        password: @password,
        authentication_salt: @authentication_salt,
        encryption_salt: encryption_salt
      )

      # Send confirmation email, and return the user.
      user.tap(&:send_confirmation_instructions)
    end

    def create_new_user
      User.create!(
        name: @name,
        email: @email,
        password: @password,
        authentication_salt: @authentication_salt,
        encryption_salt: encryption_salt
      )
    end

    def user
      @user ||= User.find_by(email: @email)
    end

    def encryption_salt
      SecureRandom.hex(32)
    end
  end
end
