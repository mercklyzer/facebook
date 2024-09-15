class RemoveIndexOnFriendships < ActiveRecord::Migration[7.1]
  def change
    # allowed in the scenario where a friend request was previously rejected
    # and decided to send another friend request
    remove_index :friendships, column: [:sender_id, :receiver_id]
  end
end
