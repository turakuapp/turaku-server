class User < ApplicationRecord
  # Others devise modules available are: :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :sessions, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships
  has_many :incoming_invitations, class_name: 'Invitation', foreign_key: 'invited_user_id', dependent: :destroy
  has_many :outgoing_invitations, class_name: 'Invitation', foreign_key: 'inviting_user_id', dependent: :restrict_with_exception

  validates :email, uniqueness: true, presence: true

  attr_writer :skip_password

  # A password is not required if the skip_password flag is set.
  def password_required?
    instance_variable_defined?(:@skip_password) ? !@skip_password : true
  end

  # Do not send confirmation email if skipping password. This is for when inviting a user who is not already registered.
  def confirmation_required?
    confirmed? ? false : password_required?
  end
end
