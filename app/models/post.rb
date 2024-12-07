class Post < ApplicationRecord
  include Visible

  belongs_to :user

  has_rich_text :content

  validates :title, :content, presence: :true
end
