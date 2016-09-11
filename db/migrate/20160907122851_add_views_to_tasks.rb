class AddViewsToTasks < ActiveRecord::Migration[5.0]
  def change
    add_column :tasks, :numviews, :integer, default:0
  end
end
