class Friendship < ApplicationRecord
  enum :status, {pending: 0, accepted: 1, rejected: 2}

  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validate :unique_friendship, on: :create
  validate :friendship_not_to_self

  # returns friendship records with sender and receiver's username
  scope :enriched_friendships, -> (user_id, status) do
    query = joins("JOIN users AS sender ON friendships.sender_id = sender.id")
    .joins("JOIN users AS receiver ON friendships.receiver_id = receiver.id")
    .where("sender_id = ? OR receiver_id = ?", user_id, user_id)

    query = query.where(status: statuses[status]) if statuses[status].present?

    query.select("
        friendships.id,
        friendships.sender_id,
        sender.username AS sender_username,
        friendships.receiver_id,
        receiver.username AS receiver_username,
        friendships.status,
        friendships.created_at,
        friendships.updated_at
      ")
  end

  def accept_friend_request
    decide_friend_request(:accepted)
  end

  def reject_friend_request
    decide_friend_request(:rejected)
  end

  private

  def friendship_not_to_self
    errors.add(:base, "A friendship pointing to self is not allowed") if sender_id == receiver_id
  end

  def unique_friendship
    friendship = existing_friendship
    return if friendship.blank?

    error_message = if friendship.accepted?
      "Both users are already friends"
    elsif friendship.pending?
      "A friend request has already been sent"
    end

    errors.add(:base, error_message)
  end

  def existing_friendship
    Friendship.where.not(status: :rejected).find_by(sender_id: sender_id, receiver_id: receiver_id) ||
    Friendship.where.not(status: :rejected).find_by(sender_id: receiver_id, receiver_id: sender_id)
  end

  def decide_friend_request(status)
    if accepted?
      errors.add(:base, "Friend request has already been accepted")
      return false
    elsif rejected?
      errors.add(:base, "Friend request has already been rejected") if rejected?
      return false
    end

    update(status: status)
  end
end
