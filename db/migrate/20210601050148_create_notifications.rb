class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id
      t.integer :visited_id
      t.integer :post_id
      t.string :action
      t.boolean :checked, null: false, default: false

      t.timestamps
    end
  end
end
