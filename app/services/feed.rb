class Feed
  include ActiveModel::Model
  attr_reader :user

  def initialize(user)
    @user = user
    @blog_post_id = BlogPost.all
  end

  def blog_posts
    BlogPost.find(blog_post_ids)
  end


  private

     def user_ids
       @user.following_ids + [@user.id]
     end

     def following_users_post_ids
      BlogPost.where(user_id: @user.following_ids).pluck(:id)
     end

     def tagged_post_ids
       Tagging.where(tag_id: @user.following_tag_ids).pluck(:blog_post_id).uniq
     end

     def blog_post_ids
      BlogPost.all
     end
end