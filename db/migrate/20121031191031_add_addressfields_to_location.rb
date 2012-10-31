class AddAddressfieldsToLocation < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.string :street1
      t.string :street2
      t.string :city
      t.string :state
      t.integer :zip

      t.remove :address
    end
  end
end
