class RemoveUserIdAndAddReference < ActiveRecord::Migration
  def change
    remove_column :items, :user_id
    add_reference :items, :loser, index: true
    add_reference :items, :founder, index: true
  end
end
