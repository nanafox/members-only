class Post < ApplicationRecord
  include Visible

  belongs_to :user

  has_rich_text :content
  has_many :comments, dependent: :delete_all

  validates :title, :content, :status, presence: :true
end
