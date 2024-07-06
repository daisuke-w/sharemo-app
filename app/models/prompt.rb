class Prompt < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  has_many   :notes
  belongs_to :category
  has_many   :prompt_tags, dependent: :destroy
  has_many   :tags, through: :prompt_tags
  has_one    :reference, as: :referencable, dependent: :destroy
end
