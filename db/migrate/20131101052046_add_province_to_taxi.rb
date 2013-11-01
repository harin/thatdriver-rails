class AddProvinceToTaxi < ActiveRecord::Migration
  def change
    add_column :taxis, :province, :string
  end
end
