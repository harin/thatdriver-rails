class AddFieldsToFoundItem < ActiveRecord::Migration
  def change
    add_column :found_items, :item_name, :string
    add_column :found_items, :plate_no, :string
    add_column :found_items, :taxi_description, :text
    add_column :found_items, :contact, :string
  end
end
