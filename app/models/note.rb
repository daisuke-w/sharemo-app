class Note < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :prompt, optional: true
  belongs_to :category
  has_many   :note_tag
  has_many   :tags, through: :note_tag
end
