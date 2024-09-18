require 'sidekiq-scheduler'

class FollowerActivityScheduler
  include Sidekiq::Worker
  def perform
    users = User.all
    users.each do |user|
      user.followers.each do |follower|
      FollowerActivityJob.perform_later(user.email,follower.blog_posts.count, follower.responses.count)
      end
    end
  end
end