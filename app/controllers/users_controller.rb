class UsersController < ApplicationController
  def index
    @users = User.all
    @users.each do |user|
      MetricEmailJob.perform_later(user.id)
    end
    render json: UserBluePrinter.render(@users)
  end

  def show
    @user = User.find_by_id(params[:id])
  end
  
# Sets @relationship for Unfollow button
def check_for_relationship
  if current_user.following?(@user)
    @relationship = current_user.active_relationships.find_by(followed_id: @user.id)
  end
end

end
