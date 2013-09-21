class CreateLostItems < ActiveRecord::Migration
  def change
    create_table :lost_items do |t|
      t.boolean :returned
      t.string :location
      t.datetime :when
      t.text :description
      t.belongs_to :user

      t.timestamps
    end
  end
end
