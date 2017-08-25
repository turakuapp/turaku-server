class User < ApplicationRecord
  # Others devise modules available are: :lockable, :timeoutable, :registerable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :sessions, dependent: :destroy

  validates :name, presence: true
  validates :email, uniqueness: true, presence: true
end
