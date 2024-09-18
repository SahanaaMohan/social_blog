require 'sidekiq-scheduler'

class PostPublishScheduler
  include Sidekiq::Worker
  def perform
    blog_posts = BlogPost.scheduled
    #BlogPost.where(published_at > Time.current)
    blog_posts.each do |blog_post|
      user = User.find(blog_post.user_id)
      ScheduleEmailJob.perform_later(user.email,blog_post)
    end
  end
end