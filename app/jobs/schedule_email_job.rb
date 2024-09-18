class ScheduleEmailJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_mail,blog_post)
    WelcomeMailer.send_scheduled_digest_daily(user_mail,blog_post).deliver_now
  end

end