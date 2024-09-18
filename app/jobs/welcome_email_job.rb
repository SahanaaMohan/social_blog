class WelcomeEmailJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find(user_id)
    WelcomeMailer.send_new_user_message(user).deliver_now
  end

end