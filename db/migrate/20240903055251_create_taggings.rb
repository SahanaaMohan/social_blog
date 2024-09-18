class CreateTaggings < ActiveRecord::Migration[7.0]
  def change
    create_table :taggings do |t|
      t.belongs_to :blog_post, index: true, foreign_key: true
      t.belongs_to :tag, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
