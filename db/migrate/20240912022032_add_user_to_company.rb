class AddUserToCompany < ActiveRecord::Migration[7.0]
  def change
    add_reference :companies, :user, index: true
  end
end
