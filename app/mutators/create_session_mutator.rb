class CreateSessionMutator < ApplicationMutator
  attr_accessor :email
  attr_accessor :password

  validates :email, email: true

  validate :credentials_must_be_authentic
  validate :user_must_be_confirmed

  def credentials_must_be_authentic
    return if user.present? && user.valid_password?(password)

    errors.add(:base, 'AuthenticationFailure')
  end

  def user_must_be_confirmed
    return if user.blank?

    errors.add(:base, 'UnconfirmedEmail') unless user.confirmed?
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def create_session
    Sessions::CreateService.new(user).create
  end
end
