class AddCompany < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :companies, index: true, foreign_key: true
  end
end

