module ApplicationHelper
  include Pagy::Frontend
  def follow_tag_button_for(tag)
    if user_signed_in?
      if current_user.following_tag?(tag)
        render 'shared/unfollow_tag_button'
      else
        render 'shared/follow_tag_button'
      end
    else
      render 'shared/follow_tag_button'
    end
  end
end
