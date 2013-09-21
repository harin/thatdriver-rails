class CreateFoundItems < ActiveRecord::Migration
  def change
    create_table :found_items do |t|
      t.boolean :returned
      t.string :location
      t.datetime :when
      t.text :description
      t.belongs_to :taxi

      t.timestamps
    end
  end
end
