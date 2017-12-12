class Entry < ApplicationRecord
  belongs_to :team
  belongs_to :user

  has_many :entry_taggings
  has_many :tags, through: :entry_taggings
end
