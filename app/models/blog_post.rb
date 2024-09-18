class BlogPost < ApplicationRecord
  require 'elasticsearch/model'
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  
  include Notificable
  has_rich_text :content
  has_one_attached :cover_image
  validates:title, presence:true
  validates:content, presence:true
  belongs_to :user
  has_many :responses, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :likes
  after_create :notify_users
  has_many :bookmarks
  
  scope :sorted, ->{ order(arel_table[:published_at].desc.nulls_first).order(updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :published, -> { where("published_at <= ?", Time.current) }
  scope :scheduled, -> { where("published_at > ?", Time.current) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end 

    def notify_users
        ActionCable.server.broadcast("room_channel", {
            title: self.title,
            body: self.content
        })
      end

      def self.tagged_with(name)
        Tag.find_by!(name: name).blog_posts
      end
    
      def all_tags=(names)
        self.tags = names.split(",").map do |name|
          Tag.where(name: name.strip).first_or_create!
        end
      end
    
      def all_tags
        tags.map(&:name).join(", ")
      end


      #def blog_post_for
      #  tag_id = @user.following_tag_ids.select { |id| blog_post.tag_ids.include?(id) }.first
      #  BlogPost.find_by(id: tag_id)
     # end   
end