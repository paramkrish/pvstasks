class AddFieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :mobile, :integer
    add_column :users, :address, :text
    add_column :users, :city, :string
    add_column :users, :country, :string
  end
end
