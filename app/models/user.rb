class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :group_id, presence: true, numericality: { other_than: 1, message: "can't be blank" }

  has_many :notes
  has_many :prompts
  has_one_attached :user_image
  belongs_to :group
end
