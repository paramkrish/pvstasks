class CreatePreferences < ActiveRecord::Migration[5.0]
  def change
    create_table :preferences do |t|
      t.integer :user_id
      t.boolean :notifyfor_newtask
      t.boolean :notifyfor_taskupdate
      t.boolean :notifyfor_comment2task
      t.boolean :notifyfor_taskcomplete

      t.timestamps
    end
  end
end
