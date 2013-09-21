class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.text :comment
      t.integer :rating
      t.belongs_to :user
      t.belongs_to :taxi

      t.timestamps
    end
  end
end
