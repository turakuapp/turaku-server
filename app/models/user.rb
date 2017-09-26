class User < ApplicationRecord
  # Others devise modules available are: :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :sessions, dependent: :destroy
  has_many :team_memberships, dependent: :destroy
  has_many :teams, through: :team_memberships

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
end
