class DropResponses < ActiveRecord::Migration[7.0]
  def change
    drop_table :responses
  end
end
