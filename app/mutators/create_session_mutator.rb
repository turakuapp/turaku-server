class CreateSessionMutator < ApplicationMutator
  attr_accessor :email
  attr_accessor :password

  validates :email, email: true

  validate :must_be_authentic

  def must_be_authentic
    begin
      @user = Users::AuthenticationService.new(email, password).authenticate
    rescue Sessions::AuthenticationFailureException
      errors[:base] << 'AuthenticationFailure'
    rescue Sessions::UnconfirmedEmailException
      errors[:base] << 'UnconfirmedEmail'
    end
  end

  def create_session
    Sessions::CreateService.new(@user).create
  end
end
