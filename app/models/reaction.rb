class Reaction < ApplicationRecord
  reaction_types = ['like', 'heart', 'care', 'haha', 'wow', 'sad', 'angry'].freeze

  belongs_to :user
  belongs_to :owner, polymorphic: true

  validates :user_id, uniqueness: { scope: [:owner_id, :owner_type], message: 'already has an entry' }
  validates :reaction, inclusion: { in: reaction_types, message: 'Invalid reaction' }

  # Dynamically define class methods for each reaction
  reaction_types.each do |key|
    singleton_class.define_method("add_#{key}") do |user, owner|
      Reaction.create(user: user, owner: owner, reaction: key)
    end
  end
end
