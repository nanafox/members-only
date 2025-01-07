class Post < ApplicationRecord
  include Visible

  belongs_to :author, class_name: "User", foreign_key: "user_id"
  has_rich_text :content

  before_save :set_slug

  has_many :comments, -> {
      includes(:author, { replies: :replies }).order(created_at: :desc)
    }, dependent: :delete_all

  scope :recent, -> {
      order(created_at: :desc)
        .includes(:rich_text_content)
    }

  scope :for_current_user, ->(current_user) {
      order(created_at: :desc)
        .includes(:rich_text_content, :user)
        .where(user: current_user)
    }

  validates :slug, uniqueness: true

  validates :title, :content, :status, presence: :true

  # Change the param from id to slug for posts
  def to_param
    slug
  end

  # The user method is an alias for the author method
  def user
    author
  end

  private

  def set_slug
    pattern = /[\W\s]/
    replacement = "-"
    unless title.blank?
      if title_changed?
        self.slug = "#{title.gsub(pattern, replacement).downcase}-#{SecureRandom.urlsafe_base64}".downcase
      else
        self.slug ||= "#{title.gsub(pattern, replacement).downcase}-#{SecureRandom.urlsafe_base64}".downcase
      end
    end
  end
end
