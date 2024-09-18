require 'sidekiq-scheduler'

class UserActivityScheduler
  include Sidekiq::Worker
  def perform
    users = User.all
    users.each do |user|
      UserActivityJob.perform_later(user.email,user.blog_posts.count, user.responses.count)
    end
  end
end