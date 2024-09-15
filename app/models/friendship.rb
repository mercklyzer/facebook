class Friendship < ApplicationRecord
  enum :status, {pending: 0, accepted: 1, rejected: 2}

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validate :unique_friendship

  private

  def unique_friendship
    error_message = if accepted?
      "Friendship already exists"
    elsif pending?
      "A friend request has already been sent"
    end

    errors.add(:base, error_message) if friendship_exists?
  end

  def friendship_exists?
    Friendship.where.not(status: :rejected).exists?(sender_id: sender_id, receiver_id: receiver_id) ||
    Friendship.where.not(status: :rejected).exists?(sender_id: receiver_id, receiver_id: sender_id)
  end
end
