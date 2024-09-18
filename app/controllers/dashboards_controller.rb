class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :sort_blog_posts
  before_action :scheduled
  before_action :draft
  before_action :follower_posts

  def show
    @blog_posts = BlogPost.all.includes(:user) 
    @pagy, @blog_posts = pagy(@blog_posts)
    if user_signed_in?
      @following_tags = current_user.following_tags
    end

    if user_signed_in?
      @rec_blog_posts = @sort_posts + @scheduled + @draft
    else
      @rec_blog_posts = BlogPost.published.includes(:user)
    end

  end

  private

  def scheduled
    @scheduled = current_user.blog_posts.scheduled
   end
 
   def draft
     @draft =  current_user.blog_posts.draft
   end
 
  def sort_blog_posts
    other_users = User.all_except(current_user)
    @sort_posts ||= []
    other_users.each do |user|
      user.blog_posts.published.all.each do |blog_post|  
      @sort_posts <<  blog_post
      end
    end
  end

  def follower_posts
    @follower_posts ||= []
    current_user.followers.each do |user|
      user.blog_posts.published.all.each do |blog_post|  
      @follower_posts <<  blog_post
      end
  end
end

end