class Invitation < ApplicationRecord
  belongs_to :invited_user, class_name: 'User'
  belongs_to :inviting_user, class_name: 'User'
  belongs_to :team
end
