class CreateFavoriteNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.interger :favorite_id

      t.timestamps
    end
  end
end
