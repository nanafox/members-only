class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content
      t.string :slug
      t.string :status, null: false, default: "public"

      t.timestamps
    end
    add_index :posts, :title
    add_index :posts, :slug
    add_index :posts, :status
  end
end
