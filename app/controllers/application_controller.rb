class ApplicationController < ActionController::Base
  #これを定義するとすべてのビューから呼べるようになる
  helper_method :current_user

  private

  def current_user
    #||= nilガード：その値が存在すればそれを返し、nilの時には指定した値を返す
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
end
