class Team < ApplicationRecord
  has_many :team_memberships, dependent: :destroy
  has_many :users, through: :team_memberships
  has_many :invitations, dependent: :destroy
  has_many :invited_users, through: :invitations
  has_many :entries
end
