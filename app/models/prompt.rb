class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many   :note
  belongs_to :category
end
