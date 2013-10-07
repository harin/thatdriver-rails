class CreateLosts < ActiveRecord::Migration
  def change
    create_table :losts do |t|
      t.belongs_to :item
      t.belongs_to :user

      t.timestamps
    end
  end
end
