class RemoveNumviewsFromTasks < ActiveRecord::Migration[5.0]
  def change
    remove_column :tasks, :numviews, :integer
  end
end
