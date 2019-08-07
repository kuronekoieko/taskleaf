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
    #findは、Task.find_by(id: params[:id])と同じ
    #idで検索するメソッド
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク#{task.name}を更新しました"
  end

  # saveに！つけるのはなぜ？
  # → バリデーション(検証エラー)時にfalseを返すのではなく例外を発生させる
  # フラッシュメッセージ
  # →リダイレクトする時に送れる
  # →application.html.slimで、フラッシュメッセージが存在する時に表示されるようにする(ifでタグを囲む)
  # →フラッシュメッセージは次のリダイレクトまで残る。次の次には消える
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to @task, notice: "タスク#{@task.name}を登録しました"
    else
      render :new
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク#{task.name}を削除しました"
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
