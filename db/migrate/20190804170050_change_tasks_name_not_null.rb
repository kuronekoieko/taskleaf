class ChangeTasksNameNotNull < ActiveRecord::Migration[5.2]
  def change
    # 既存のテーブルの既存のカラムのnot null制約をつけたり外したりできる
    # 引数ーテーブル名、カラム名、nullを許容するかどうか
    change_column_null :tasks, :name, false
  end
end
