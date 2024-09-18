class MoveBodyToActionText1 < ActiveRecord::Migration[7.0]
  def change
    BlogPost.all.find_each do |blog_post|
      blog_post.update(content: blog_post.body)
    end
  end
end