class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end
    add_index :tags, :name
    end
end
