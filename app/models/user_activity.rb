class UserActivity < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :entry
end
