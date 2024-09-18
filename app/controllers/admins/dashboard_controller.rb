class Admins::DashboardController < ApplicationController
  def index
    @blog_posts = BlogPost.all.published
    @rooms = Room.all
    @tags = Tags.all
    @users = Users.all
  end
end
