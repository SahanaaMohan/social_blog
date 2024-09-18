class FollowerActivityJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_mail,post_count, response_count)
    FollowerActivityMailer.send_digest_weekly(user_mail,post_count, response_count).deliver_now
  end

end