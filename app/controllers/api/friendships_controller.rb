module Api
  class FriendshipsController < AuthenticatedBaseController
    def self.find_resource_by_id_scoped_methods
      [:accept_friend_request, :reject_friend_request]
    end

    include FindableResource

    def index
      status = Friendship.statuses[params[:status]] ? params[:status] : nil
      friendships = Friendship.enriched_friendships(user.id, status)

      payload(data: {user_id: user.id, friendships: friendships}, status: 200)
    end

    def send_friend_request
      receiver_id = friendship_params[:receiver_id] || 0
      receiver = User.find_by(id: receiver_id)

      return payload(errors:["Receiver does not exist."], status: 400) unless receiver.present?

      friend_request = user.send_friend_request(receiver)

      if friend_request.persisted?
        payload(data: friend_request, status: 200)
      else
        payload(errors: friend_request.errors.map(&:full_message), status: 400)
      end
    end

    def accept_friend_request
      if @friendship.accept_friend_request
        payload(data: @friendship, status: 200)
      else
        payload(errors: @friendship.errors.map(&:full_message), status: 400)
      end
    end

    def reject_friend_request
      if @friendship.reject_friend_request
        payload(data: @friendship, status: 200)
      else
        payload(errors: @friendship.errors.map(&:full_message), status: 400)
      end
    end

    private

    def friendship_params
      params.require(:friends).permit(:receiver_id)
    end
  end
end
