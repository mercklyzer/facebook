class Post < ApplicationRecord
  belongs_to :user
  has_many :reactions, as: :owner, dependent: :destroy

  validates :content, presence: true
end
