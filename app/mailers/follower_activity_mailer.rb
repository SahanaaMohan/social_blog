class FollowerActivityMailer < ApplicationMailer
  default from: 'sahanaamohan@gmail.com' # this domain must be verified 

  def send_digest_weekly(user_mail,post_count, response_count)
    @p_count = post_count
    @r_count = response_count
  subject_with_name = "#{user_mail} follower Activities"
  body_with_name = "Post count: #{post_count} Like count #{response_count}"
  mail(to: user_mail, :subject => subject_with_name)
  end
  
end
