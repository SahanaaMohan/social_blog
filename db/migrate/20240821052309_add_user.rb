class AddUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :blog_posts, :user, index: true, foreign_key: true
  end
end