class CreateUserMutator < ApplicationMutator
  attr_accessor :name
  attr_accessor :email
  attr_accessor :password
  attr_accessor :authentication_salt

  validates :email, email: true
  validates :authentication_salt, format: { with: /\A[0-9a-f]{64}\z/, message: 'InvalidAuthenticationSalt' }

  validate :register_only_once

  def register_only_once
    return if user.blank?
    return if user.authentication_salt.blank?

    errors.add(:base, 'AlreadyRegistered')
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def create_user
    Users::CreateService.new(name, email, password, authentication_salt).create
  end
end
