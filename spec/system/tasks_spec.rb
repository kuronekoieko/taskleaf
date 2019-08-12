# encoding: utf-8
require "rails_helper"

describe "タスク管理機能", type: :system do
  describe "一覧表示機能" do
    before do
      # ユーザーAを作成しておく
      # :userファクトリを指定してUserオブジェクトを作成する
      # FactoryBot.createでデータの生成、データベースに保存まdやってくれる
      # FactoryBot.buildで生成だけできる
      # user_a = FactoryBot.create(:user)
      # 一部の属性を変更してデータを作ることもできる
      user_a = FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com")
      # 作成者がユーザーAであるタスクを作成しておく
      FactoryBot.create(:task, name: "最初のタスク", user: user_a)
    end
    context "ユーザーAがログインしているとき" do
      before do
        # ユーザーAでログインする
        # 特定のURLでアクセスする、という動作はvisit [URL]という動作でできる
        visit login_path
        # 「メールアドレス」というラベル(<label>要素)がついた
        # テキストフィールド(<input>)要素にメールアドレスを入れる
        # fill_in "ラベル値", with "インプット値"
        fill_in "メールアドレス", with: "a@example.com"
        fill_in "パスワード", with: "password"
        # 「ログインする」ボタンを押す
        click_button "ログインする"
      end

      it "ユーザーAが作成したタスクが表示される" do
        # 作成済みタスクの名称が画面上に表示されていることを確認
        # have_contentの部分は「マッチャ(Macher)」と呼ばれる
        expect(page).to have_content "最初のタスク"
      end
    end
    context "ユーザーBがログインしているとき" do
      before do
        # ユーザーBを作成しておく
        FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com")
        # ユーザーBでログインする
        visit login_path
        fill_in "メールアドレス", with: "b@example.com"
        fill_in "パスワード", with: "password"
        click_button "ログインする"
      end
      it "ユーザーAが作成したタスクが表示されない" do
        # ユーザーAが作成したタスクの名称が画面上に表示されていないことを確認
        expect(page).to have_no_content "最初のタスク"
      end
    end
  end
end
