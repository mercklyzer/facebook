class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, as: :owner, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :content, presence: true
end
