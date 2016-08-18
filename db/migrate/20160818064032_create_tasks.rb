class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :remarks
      t.date :due_date
      t.string :owner
      t.integer :status
      t.integer :priority
      t.integer :category_id

      t.timestamps
    end
  end
end
