class BlogPostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :view]
  before_action :set_blog_post, except: [:index, :new, :create, :scheduled, :view]
  before_action :is_author?, only: [:edit, :update, :destroy]
  before_action :check_logged_in_user, only: [:index]


  def index
    @blog_posts = user_signed_in? ? BlogPost.all : BlogPost.published.sorted
    @pagy, @blog_posts = pagy(@blog_posts)
  end

  def view
    @blog_posts =  BlogPost.all 
    render json: BlogPostBluePrinter.render(@blog_posts)
  end

  def show
    @response = Response.new
    @likes = Like.new
  end

  def scheduled
    @blog_posts = BlogPost.scheduled.sorted
  end

  def new
    @blog_post = BlogPost.new
  end

  def edit
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render:new, status: :unprocessable_entity
    end
  end

  def create
    @blog_post = current_user.blog_posts.new(blog_post_params)
    if @blog_post.save
      #redirect_to @blog_post
      redirect_to dashboard_url, notice: "Successfully created a post!"
    else
      render:new, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private 
  def blog_post_params
    params.require(:blog_post).permit(:title,:content,:cover_image,:published_at,:user_id,:likes,:all_tags)
  end

  def set_blog_post
    @blog_post = user_signed_in? ? BlogPost.find(params[:id]) : BlogPost.published.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end

  def authenticate_user!
    redirect_to new_user_session_path, alert: "Kindly sign in our sign up to continue" unless user_signed_in?
  end

  def is_author?
    user_id = @blog_post.user_id
    user_mail = User.find(user_id).email
    user_name = user_mail.split('@').first
  redirect_to root_path, alert: "Post created by another user!  #{user_name}"  unless @blog_post.user == current_user 
  end

  def check_logged_in_user
    redirect_to dashboard_url if user_signed_in?
  end

end