class CreateFriendships < ActiveRecord::Migration[7.1]
  def change
    create_table :friendships do |t|
      t.references :sender, null: false, foreign_key: {to_table: :users}
      t.references :receiver, null: false, foreign_key: {to_table: :users}
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :friendships, [:sender_id, :receiver_id], unique: true
  end
end
