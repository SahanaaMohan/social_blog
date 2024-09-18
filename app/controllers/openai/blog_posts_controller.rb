class Openai::BlogPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog_post, only: [:edit]
  before_action :get_blog_ai_post, only: [:update]

  def create
    new_blog_post = current_user.blog_posts.new
    new_blog_post.content = "AI said:" + OpenaiCommenter.call(new_blog_post.body)
    if new_blog_post.save
      redirect_to blog_post, notice: "AI updated blog post"
    end
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render:new, status: :unprocessable_entity
    end
  end

  def edit
    @edit_post ||= BlogPost.find(params[:blog_post_id])
    @content_post = @edit_post.content
    @content_body = @edit_post.body
    @edit_post.body = @content_post.to_plain_text
    @edit_post.content = @content_body
    if @edit_post.save
      redirect_to blog_post_url, notice: "AI content updated in post"
    end
  end

  private

  def set_blog_post
    @blog_post ||= BlogPost.find(params[:blog_post_id])
  end

  def get_blog_ai_post
    @new_post ||= BlogPost.find(params[:blog_post_id])
    @new_post.body = "AI updated content as:" + OpenaiCommenter.call(@new_post.content.to_plain_text)
    if @new_post.save
      redirect_to blog_post_url, notice: "AI has responded"
    end
  end
  
  def blog_post_params
    params.require(:blog_post).permit(:title,:content,:cover_image,:published_at,:user_id,:likes,:all_tags)
  end

end
