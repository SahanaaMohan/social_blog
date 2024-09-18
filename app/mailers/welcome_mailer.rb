class WelcomeMailer < ApplicationMailer
  default from: 'sahanaamohan@gmail.com' # this domain must be verified 
  def welcome
    @url = 'https://mailersend.com/login'
    mail(to: "sahanaamk@gmail.com", subject: "Welcome to our medium app!")
  end

  def send_new_user_message(user)
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def send_login_message(user)
  mail(to: user.email, subject: 'Login to My Awesome Site')
  end

  def send_scheduled_digest_daily(user_email,blog_post)
  @blog_post = blog_post
  subject_with_name = "#{user_email} Scheduled post"
  body_with_name = "Scheduled post for #{@blog_post.title} at #{@blog_post.published_at}"
  mail(to: user_email, :subject => subject_with_name)
  end
  
end
