class Users::RecommendedPostsController < ApplicationController
  def index
    @recommended_posts = current_user.blog_posts.all
  end
end