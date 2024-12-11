class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :lockable

  has_many :posts, dependent: :delete_all
  has_many :comments, dependent: :delete_all

  validates :username, uniqueness: { message: "has already been taken, try another one" }

  # Users that this user is following
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :active_relationships, source: :followed

  # Users following this user
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower

  # Builds the full name for the current user using their first and last names.
  def fullname
    "#{first_name} #{last_name}"
  end

  # Returns the initials for an instance of the user model. Initials are made up
  # of the first letters of the user's first and last names.
  def initials
    "#{first_name.first}#{last_name.first}"
  end

  def follows?(other)
    followed_users.include?(other)
  end
end
