class User < ApplicationRecord
  has_many :posts, dependent: :destroy

  # login/signup
  has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :password,
    presence: true,
    length: {within: 8..ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED}
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :username_should_not_match_any_email

  # friendships
  has_many :sent_friend_requests, class_name: 'Friendship', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friend_requests, class_name: 'Friendship', foreign_key: 'receiver_id', dependent: :destroy

  # friendships and friends couldn't be associations the way this is designed
  # because we need to pass 2 possible foreign keys at the same time: sender_id and receiver_id
  # and ActiveRecord does not support that. If foreign key is not specified, it looks user_id.
  def friendships
    Friendship.where('sender_id = ? OR receiver_id = ?', id, id)
  end

  def friends
    User.joins("INNER JOIN friendships ON friendships.sender_id = users.id OR friendships.receiver_id = users.id")
      .select('users.*, friendships.status')
      .where(friendships: {status: Friendship.statuses[:accepted]})
      .where('friendships.sender_id = :id OR friendships.receiver_id = :id', id: id)
  end

  # to see if successful, check for #persisted? and get #errors
  def send_friend_request(other_user)
    sent_friend_requests.create(receiver: other_user)
  end

  def accept_friend_request(other_user)
    friend_request = received_friend_requests.find_by(sender: other_user)
    friend_request.accept_friend_request
  end

  def reject_friend_request(other_user)
    friend_request = received_friend_requests.find_by(sender: other_user)
    friend_request.reject_friend_request
  end

  private

  def username_should_not_match_any_email
    if User.where(email: username).exists? || User.where(username: email).exists?
      errors.add(:username, "has already been taken")
    end
  end
end
