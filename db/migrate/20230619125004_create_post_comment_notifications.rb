class CreatePostCommentNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :post_comment_notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :post_commnet_id

      t.timestamps
    end
  end
end
