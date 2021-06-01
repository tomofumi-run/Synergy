class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :genre_id
      t.string :post_image_id
      t.integer :likes_count
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
