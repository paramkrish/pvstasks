class AddAssignedtoTasks < ActiveRecord::Migration[5.0]
  def change
  	add_column :tasks, :assignedto_id, :integer
  end
end
