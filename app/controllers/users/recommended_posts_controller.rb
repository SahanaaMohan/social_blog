class Users::RecommendedPostsController < ApplicationController
  before_action :recommend_posts
  def index
    @recommended_posts = @sorted_recommended
  end

  def recommend_posts
    followers = current_user.followers
    recommended = Hash.new(0)
    puts('inside post')
    followers.each do |user|
      common_tags = current_user.following_tags & user.following_tags
      weight = common_tags.size.to_f / current_user.following_tags.size
      common_tags.each do |post|
        recommended[post] += weight
      end
    end
    @sorted_recommended = recommended.sort_by { |key, value| value }.reverse
  end

end