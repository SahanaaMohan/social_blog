class Bookmark < ApplicationRecord
  belongs_to :blog_post
  belongs_to :user
end
