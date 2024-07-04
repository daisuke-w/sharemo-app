class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many   :note
  belongs_to :category
  has_many   :prompt_tag
  has_many   :tags, through: :prompt_tag
end
