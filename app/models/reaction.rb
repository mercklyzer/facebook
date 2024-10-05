class Reaction < ApplicationRecord
  enum :reaction, {like: 0, heart: 1, care: 2, haha: 3, wow:4, sad: 5, angry: 6}

  belongs_to :user
  belongs_to :owner, polymorphic: true

  validates :user_id, uniqueness: { scope: [:owner_id, :owner_type], message: 'already has an entry' }
  validates :reaction, inclusion: { in: reactions.keys }

  # Dynamically define class methods for each reaction
  reactions.keys.each do |key|
    # to see if creation is successful, check for #persisted? and get #errors
    singleton_class.define_method("add_#{key}") do |user, owner|
      Reaction.create(user: user, owner: owner, reaction: key)
    end
  end
end
