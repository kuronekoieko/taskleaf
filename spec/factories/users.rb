# encoding: utf-8
FactoryBot.define do
  # :userという名前のUserクラスのファクトリを定義
  # 名前から自動的に類推してくれる
  # ファクトリとクラス名が違う場合には:classオプションをつける
  # factory :admin_user, class: User do
  factory :user do
    name { "テストユーザー" }
    email { "test@example.com" }
    password { "password" }
  end
end
