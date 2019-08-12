# encoding: utf-8
FactoryBot.define do
  factory :task do
    name { "テストを書く" }
    description { "いろいろやる" }
    # :userという名前のfacrtoryを、
    # taskモデルに定義されたuserという名前の関連を生成するのに利用する
    # 関連名とファクトリ名が異なる場合には次のように書く
    # association :user,factory: :admin_user
    user
  end
end
