class CreateFollowNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :follow_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :follow

      t.timestamps
    end
  end
end
