class RemoveUsernameFromComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :comments, :username, :string
  end
end
