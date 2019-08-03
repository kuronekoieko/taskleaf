# encoding: utf-8
class TasksController < ApplicationController
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

  def create
    task = Task.new(task_params)
    task.save!
    redirect_to tasks_url, notice: "タスク#{task.name}を登録しました"
  end

  private

  # リクエストパラメータとして送られて来た値が想定通りtask:{...}の形式であるかをチェックする。悪意のあるデータが送られてくる対策。Strong parametersと呼ばれる
  def task_params
    params.require(:task).permit(:name, :description)
  end
end
