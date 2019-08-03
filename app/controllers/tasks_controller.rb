# encoding: utf-8
class TasksController < ApplicationController
=begin
複数行のコメント
スペースは開けない
=end
  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  # saveに！つけるのはなぜ？
  # フラッシュメッセージ
  # →リダイレクトする時に送れる
  # →application.html.slimで、フラッシュメッセージが存在する時に表示されるようにする(ifでタグを囲む)
  # →フラッシュメッセージは次のリダイレクトまで残る。次の次には消える
  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク#{task.name}を登録しました"
  end

  # ルーティングしないメソッドはprivateにしておく？
  private

  # リクエストパラメータとして送られて来た値が想定通りtask:{...}の形式であるかをチェックする。
  # 悪意のあるデータが送られてくる対策。
  # Strong parametersと呼ばれる
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
