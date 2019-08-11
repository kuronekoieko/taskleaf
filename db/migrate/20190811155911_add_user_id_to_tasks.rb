class AddUserIdToTasks < ActiveRecord::Migration[5.2]
  def up
    # 今までのタスクがすべて消去される
    # 既存のタスクがある状態でuser_idを追加するとnotnull制約に引っかかる
    execute "DELETE FROM tasks;"
    add_reference :tasks, :user, null: false, index: true
  end

  def down
    remove_reference :tasks, :user, index: true
  end
end
