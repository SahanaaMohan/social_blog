class AddBodyToBlogPost < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :body, :text
    add_column :blog_posts, :content, :text
  end
end
