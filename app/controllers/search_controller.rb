class SearchController < ApplicationController
  def search
    @blog_posts = BlogPost.search(params[:search][:q]).records.to_a
  end
end