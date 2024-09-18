class Response < ActiveRecord::Base
  validates :body, presence: true
  validates :blog_post_id, :user_id, presence: true

  belongs_to :blog_post
  belongs_to :user
  after_commit :create_notifications, on: :create

  private
  def create_notifications
    Notification.create do |notification|
      notification.notify_type = 'blog_post'
      notification.actor = self.user
      notification.user = self.blog_post.user
      notification.target = self
      notification.second_target = self.blog_post
    end
  end
end