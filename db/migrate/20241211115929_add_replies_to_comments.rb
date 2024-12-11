class AddRepliesToComments < ActiveRecord::Migration[8.0]
  def change
    add_reference :comments, :reply, foreign_key: { to_table: :comments }
  end
end
