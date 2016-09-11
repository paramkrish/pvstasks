class RemoveOwnerFromTasks < ActiveRecord::Migration[5.0]
  def change
  	    remove_column :tasks, :owner, :integer
  end
end
