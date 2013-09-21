class CreateTaxis < ActiveRecord::Migration
  def change
    create_table :taxis do |t|
      t.string :plate_no
      t.string :owner
      t.string :color

      t.timestamps
    end
  end
end
