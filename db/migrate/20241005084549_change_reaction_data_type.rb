class ChangeReactionDataType < ActiveRecord::Migration[7.1]
  def change
    change_column :reactions, :reaction, :string
  end
end
