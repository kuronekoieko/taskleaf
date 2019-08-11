# encoding: utf-8
class SessionsController < ApplicationController
  def new
  end

  # セッションを作る
  def create
    user = User.find_by(email: session_params[:email])
    # ユーザーが見つかった場合はauthenticateメソッドでパスワード認証をする
    # authenticateメソッド:Userクラスにhas_secure_passswordと記述した時に
    # 自動で追加された認証のためのメソッド
    # 引数で受け取ったパスワードをハッシュ化して、
    # その結果がUserオブジェクト内部に保存されているdigestと一致するかどうかを調べる
    # 一致していたらUserオブジェクトを、一致していなければfalseを返す
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
