class BlogPosts::LikesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_blog_post

  def create
    @blog_post.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @blog_post }
      format.js
    end
  end
  
  def destroy
    @blog_post.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @blog_post }
      format.js
    end
  end

  private

    def set_blog_post
      @blog_post = BlogPost.find(params[:blog_post_id])
    end
end