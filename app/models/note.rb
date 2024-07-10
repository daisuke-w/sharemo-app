class Note < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  include CommonMethods

  belongs_to :user
  belongs_to :prompt, optional: true
  belongs_to :category
  has_many   :note_tags, dependent: :destroy
  has_many   :tags, through: :note_tags
  has_one    :reference, as: :referencable, dependent: :destroy
end
