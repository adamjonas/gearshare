class CreateSharedItems < ActiveRecord::Migration
  def change
    create_table :shared_items do |t|
      t.reference :item_id
      t.reference :user_id

      t.timestamps
    end
  end
end
