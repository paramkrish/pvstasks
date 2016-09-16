class CreateTrackings < ActiveRecord::Migration[5.0]
  def change
    create_table :trackings do |t|
      t.string :task_id
      t.string :user_id
      t.text :change

      t.timestamps
    end
  end
end
