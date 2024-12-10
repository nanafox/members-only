class MakeSlugUniqueAtDatabaseLevel < ActiveRecord::Migration[8.0]
  def change
    change_table :posts do |t|
      t.remove_index :slug
      t.change :slug, :string, null: false, index: { unique: true }
    end
  end
end
