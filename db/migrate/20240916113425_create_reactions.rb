class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :owner, null: false, polymorphic: true, index: true
      t.integer :reaction, null: false

      t.timestamps
    end

    add_index :reactions, [:user_id, :owner_id, :owner_type], unique: true
  end
end
