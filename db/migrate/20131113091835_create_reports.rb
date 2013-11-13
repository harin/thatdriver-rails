class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :location
      t.datetime :time
      t.integer :action_type
      t.text :description

      t.timestamps
    end
  end
end
