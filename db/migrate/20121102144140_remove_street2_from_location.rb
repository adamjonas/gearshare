class RemoveStreet2FromLocation < ActiveRecord::Migration
  def up
    remove_column :locations, :street2
  end

  def down
    add_column :locations, :street2, :string
  end
end
