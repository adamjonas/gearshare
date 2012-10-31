class User < ActiveRecord::Migration
  def up
    add_column :users, :uid, :string
  end

  def down
    remove_column :users, :uid
  end
end
