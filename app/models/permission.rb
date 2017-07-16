class Permission < ApplicationRecord
  belongs_to :team
  belongs_to :user
  belongs_to :group
  belongs_to :entry
  belongs_to :tag
end
