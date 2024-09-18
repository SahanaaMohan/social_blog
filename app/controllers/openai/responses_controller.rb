# openai/responses_controller.rb
class Openai::ResponsesController < ApplicationController

  before_action :authenticate_user!

  def create
    new_response = current_user.responses.new
    new_response.blog_post = blog_post
    new_response.body = "AI said:" + OpenaiCommenter.call(set_response.body)
    if new_response.save
      redirect_to blog_post, notice: "AI has responded"
    end
  end

  private

  def blog_post
    @blog_post ||= BlogPost.find(params[:blog_post_id])
  end

  def set_response
    blog_post.responses.find(params[:response_id])
  end
end