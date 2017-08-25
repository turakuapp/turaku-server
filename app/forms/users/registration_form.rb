module Users
  class RegistrationForm < Reform::Form
    property :name, validates: { presence: true }
    property :email, validates: { presence: true, email: true }
    property :authentication_salt, validates: { presence: true, format: { with: /\A[0-9a-f]{64}\z/, message: 'unexpected format' } }
    property :password, validates: { presence: true }

    def save
      Users::CreateService.new(name, email, password, authentication_salt).create
    end
  end
end
