class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  # 「関連」を定義
  # これによって、user.tasksというように、そのユーザーが所有するタスクの一覧を取得できる
  has_many :tasks
end
