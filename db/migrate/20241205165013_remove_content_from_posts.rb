class RemoveContentFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_column :posts, :content, null: false
  end
end
