class Post < ApplicationRecord
  include Visible

  belongs_to :user

  has_rich_text :content
  has_many :comments, -> {
      includes(:user).order(created_at: :desc)
    }, dependent: :delete_all

  scope :recent, -> {
      order(created_at: :desc).includes(:rich_text_content).
        where("created_at > ?", 1.week.ago)
    }

  validates :slug, uniqueness: true

  validates :title, :content, :status, presence: :true

  def to_param
    slug
  end
end
