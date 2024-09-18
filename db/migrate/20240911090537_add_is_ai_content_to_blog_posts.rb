class AddIsAiContentToBlogPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :blog_posts, :ai_content, :string
  end
end
