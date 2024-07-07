class Tag < ApplicationRecord
  has_many :note_tags
  has_many :notes, through: :note_tags
  has_many :prompt_tags
  has_many :prompts, through: :prompt_tags

  validates :tag_name, uniqueness: true
end
