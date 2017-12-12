class Tag < ApplicationRecord
  belongs_to :team

  has_many :entry_taggings
  has_many :entries, through: :entry_taggings
end
