class CreateFounds < ActiveRecord::Migration
  def change
    create_table :founds do |t|
      t.belongs_to :user, index: true
      t.belongs_to :item, index: true

      t.timestamps
    end
  end
end
