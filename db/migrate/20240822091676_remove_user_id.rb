class RemoveUserId < ActiveRecord::Migration[7.0]
  def change
    remove_column :blog_posts, :user_id
  end
end
