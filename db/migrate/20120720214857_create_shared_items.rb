class CreateSharedItems < ActiveRecord::Migration
  def change
    create_table :shared_items do |t|
      t.integer :item_id
      t.integer :user_id

      t.timestamps
    end
  end
end
