class AddFieldsToItem < ActiveRecord::Migration
  def change
    add_column :lost_items, :item_name, :string
    add_column :lost_items, :plate_no, :string
    add_column :lost_items, :taxi_description, :text
    add_column :lost_items, :contact, :string
  end
end
