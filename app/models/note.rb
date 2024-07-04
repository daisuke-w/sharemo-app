class Note < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :prompt, optional: true
  belongs_to :category
end
