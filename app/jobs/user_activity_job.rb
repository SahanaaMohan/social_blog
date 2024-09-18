class UserActivityJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_mail,post_count, response_count)
    UserActivityMailer.send_digest_daily(user_mail,post_count, response_count).deliver_now
  end

end