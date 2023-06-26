class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :end_user_id
      t.string :name, null: false
      t.text :introduction, null: false
      t.boolean :is_active, null: false, default: true
      t.timestamps
    end
  end
end
