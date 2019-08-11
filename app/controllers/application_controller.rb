class ApplicationController < ActionController::Base
  #これを定義するとすべてのビューから呼べるようになる
  helper_method :current_user
  before_action :login_required

  private

  def current_user
    #||= nilガード：その値が存在すればそれを返し、nilの時には指定した値を返す
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    # unless : ifの逆バージョン
    redirect_to login_path unless current_user
  end
end
