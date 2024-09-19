class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id])
    @blog_posts = BlogPost.tagged_with(@tag.name)
  end
end