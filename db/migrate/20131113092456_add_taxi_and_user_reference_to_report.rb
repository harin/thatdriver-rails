class AddTaxiAndUserReferenceToReport < ActiveRecord::Migration
  def change
    add_reference :reports, :taxi, index: true

    add_reference :reports, :user, index: true
  end
end
