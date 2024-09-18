class AddAdminName < ActiveRecord::Migration[7.0]
  def change
    add_column :admins, :username, :string
    add_index :admins, :username, unique: true
  end
end
