class Tag < ApplicationRecord
  has_many :note_tag
  has_many :notes, through: :note_tag
  has_many :prompt_tag
  has_many :prompts, through: :prompt_tag
end
