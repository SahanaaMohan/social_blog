class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def create
    blog_post = BlogPost.find(params[:blog_post_id])
    if current_user.responses.create(body: params[:response][:body], blog_post_id: blog_post.id)
      redirect_to blog_post
    else
      redirect_to blog_post, alert: "You cannot create a blank response!"
    end
  end
end