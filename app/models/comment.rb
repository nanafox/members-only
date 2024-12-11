class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_associated :post, :user
  validates :content, presence: true

  has_many :replies, class_name: "Comment", foreign_key: "reply_id"

  belongs_to :reply, class_name: "Comment", optional: true

  def reply?
    reply_id.present?
  end
end
