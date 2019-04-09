class CreateTeamMutator < ApplicationMutator
  include AuthorizeWithUser

  attr_accessor :name
  attr_accessor :encrypted_password

  validates :encrypted_password, encrypted_object: true
  validates :name, length: { minimum: 3, maximum: 100, message: 'InvalidLength' }

  def create_team
    Users::CreateTeamService.new(current_user, name, encrypted_password).create
  end
end
