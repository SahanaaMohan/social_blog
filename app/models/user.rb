class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :username, uniqueness: { case_sensitive: false },
                       presence: true
  has_many :blog_posts, dependent: :destroy
  has_many :responses, dependent: :destroy
  has_many :likes
  after_create :send_admin_mail
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :interests, foreign_key: "follower_id", dependent: :destroy
  has_many :following_tags, through: :interests, source: :tag
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  has_many :bookmarks
  scope :all_except, ->(user) { where.not(id: user) }

  #ActiveRecord::Migration.remove_column(:users, :companies_id)

  public

  def all_except
    @users = User.all_except(current_user)
  end
  
  def send_admin_mail
    #WelcomeMailer.send_new_user_message(self).deliver_now
    WelcomeEmailJob.perform_later(self.id)
  end

  def send_login_mail
    WelcomeMailer.send_login_message(self).deliver_now
  end  

  def likes?(blog_post)
    blog_post.likes.where(user_id: id).any?
  end

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following_ids.include?(other_user)
  end

  def follow_tag(tag)
    interests.create(tag_id: tag.id)
  end

  def unfollow_tag(tag)
    interests.find_by(tag_id: tag.id).destroy
  end

  def following_tag?(tag)
    following_tag_ids.include?(tag.id)
  end

  def bookmarks?(blog_post)
    blog_post.bookmarks.where(user_id: id).any?
  end
end
