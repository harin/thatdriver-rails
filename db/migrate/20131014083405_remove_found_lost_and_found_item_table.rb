class RemoveFoundLostAndFoundItemTable < ActiveRecord::Migration
  def change
    drop_table :found_items
    drop_table :founds
    drop_table :losts
  end
end
