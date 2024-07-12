class Tag < ApplicationRecord
  has_many :note_tags
  has_many :notes, through: :note_tags
  has_many :prompt_tags
  has_many :prompts, through: :prompt_tags

  validates :tag_name, uniqueness: true
  validates :color_code, presence: true,
                         numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }
end
