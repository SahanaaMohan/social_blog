class MetricEmailJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find(user_id)
    WelcomeMailer.send_digest(user.email).deliver_now
  end

end