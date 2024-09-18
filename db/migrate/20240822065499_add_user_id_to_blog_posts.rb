class AddUserIdToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :user_id, :integer, default: 1
  end
end
