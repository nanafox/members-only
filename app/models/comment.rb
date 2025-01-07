class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "user_id"
  belongs_to :post

  validates_associated :post, :user
  validates :content, presence: true

  has_many :replies, -> {
      includes(:user).order(created_at: :desc)
    }, class_name: "Comment", foreign_key: "reply_id", dependent: :destroy

  belongs_to :reply, class_name: "Comment", optional: true

  def reply?
    reply_id.present?
  end
end
