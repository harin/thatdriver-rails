class AddTaxiToItem < ActiveRecord::Migration
  def change
    add_reference :items, :taxi, index: true
  end
end
