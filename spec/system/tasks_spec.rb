# encoding: utf-8
require "rails_helper"

describe "タスク管理機能", type: :system do

  #letを使って処理を共通化する
  #ここに書いただけでは呼ばれない
  let(:user_a) { FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com") }
  let(:user_b) { FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com") }
  # !をつけると、beforeの前にtask_aが作られる
  let!(:task_a) { FactoryBot.create(:task, name: "最初のタスク", user: user_a) }

  before do
    # ユーザーAを作成しておく
    # :userファクトリを指定してUserオブジェクトを作成する
    # FactoryBot.createでデータの生成、データベースに保存まdやってくれる
    # FactoryBot.buildで生成だけできる
    # user_a = FactoryBot.create(:user)
    # 一部の属性を変更してデータを作ることもできる
    # user_a = FactoryBot.create(:user, name: "ユーザーA", email: "a@example.com")
    # 作成者がユーザーAであるタスクを作成しておく
    FactoryBot.create(:task, name: "最初のタスク", user: user_a)

    # ユーザーAでログインする
    # 特定のURLでアクセスする、という動作はvisit [URL]という動作でできる
    visit login_path
    # 「メールアドレス」というラベル(<label>要素)がついた
    # テキストフィールド(<input>)要素にメールアドレスを入れる
    # fill_in "ラベル値", with "インプット値"
    #fill_in "メールアドレス", with: "a@example.com"
    fill_in "メールアドレス", with: login_user.email
    # fill_in "パスワード", with: "password"
    fill_in "パスワード", with: login_user.password
    # 「ログインする」ボタンを押す
    click_button "ログインする"
  end

  # itの処理を共通化する
  shared_examples_for "ユーザーAが作成したタスクが表示される" do
    it { expect(page).to have_content "最初のタスク" }
  end

  describe "一覧表示機能" do
    context "ユーザーAがログインしているとき" do
      # contextの中で定義すると、その内側でも外側でも変数のように呼び出して使える
      # ここでは上の方で定義したuser_aというletを呼び出してlogin_userとして定義している
      let(:login_user) { user_a }

      it_behaves_like "ユーザーAが作成したタスクが表示される"
      # it "ユーザーAが作成したタスクが表示される" do
      # 作成済みタスクの名称が画面上に表示されていることを確認
      # have_contentの部分は「マッチャ(Macher)」と呼ばれる
      #  expect(page).to have_content "最初のタスク"
      # end
    end

    context "ユーザーBがログインしているとき" do
      let(:login_user) { user_b }
      before do
        # ユーザーBを作成しておく
        # FactoryBot.create(:user, name: "ユーザーB", email: "b@example.com")
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

  describe "詳細表示機能" do
    context "ユーザーAがログインしているとき" do
      let(:login_user) { user_a }

      before do
        visit task_path(task_a)
      end
      it_behaves_like "ユーザーAが作成したタスクが表示される"
      # it "ユーザーAが作成したタスクが表示される" do
      #  expect(page).to have_content "最初のタスク"
      #end
    end
  end

  describe "新規作成機能" do
    let(:login_user) { user_a }

    before do
      visit new_task_path
      fill_in "名称", with: task_name
      click_button "登録する"
    end

    context "新規作成画面で名称を入力したとき" do
      let(:task_name) { "新規作成のテストを書く" }

      it "正常に登録される" do
        # have_selector…HTML内の特定のCSSセレクタで指定することができる
        # alert-successは成功時のflashメッセージを表示している要素
        expect(page).to have_selector ".alert-success", text: "新規作成のテストを書く"
      end
    end

    context "新規作成画面で名称を入力しなかったとき" do
      let(:task_name) { "" }

      it "エラーとなる" do
        # withinの中でpageの内容を検査することで、探索する範囲を画面内の特定の範囲に絞ることができる
        # error_explanation…検証エラーを表示する領域内にエラーメッセージが含まれているかどうか
        within "#error_explanation" do
          expect(page).to have_content "名称を入力してください"
        end
      end
    end
  end
end
