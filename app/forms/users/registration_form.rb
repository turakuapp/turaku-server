module Users
  class RegistrationForm < Reform::Form
    property :name, validates: { presence: { message: "BlankName" } }
    property :email, validates: { presence: { message: "BlankEmail" }, email: true }
    property :authentication_salt, validates: { presence: { message: "BlankAuthenticationSalt" }, format: { with: /\A[0-9a-f]{64}\z/, message: 'InvalidAuthenticationSalt' } }
    property :password, validates: { presence: { message: "BlankPassword" } }

    validate :register_only_once

    def register_only_once
      return if user.blank?
      return if user.authentication_salt.blank?
      errors[:base] << 'AlreadyRegistered'
    end

    def save
      Users::CreateService.new(name, email, password, authentication_salt).create
    end

    private

    def user
      @user ||= User.find_by(email: email)
    end
  end
end
