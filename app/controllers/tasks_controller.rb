class TasksController < ApplicationController
  def index
    @tasks = Task.all # allメソッドはtasksテーブルのレコードを全て取得できるメソッド
    taskcount = @tasks.size
    flash.now[:taskcount] = "  スケジュール合計#{taskcount}件" # kensuusyutoku
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:notice] = "スケジュールを新規登録しました"
      redirect_to :tasks
    else
      render "new"
    end
  end

  def show
    @task = Task.find(params[:id]) #params はGETで取得した値。task.find(1)などになる。単体レコードの抽出。
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:notice] = "スケジュールID「#{@task.id}」の情報を更新しました" #フラッシュメッセージ
      redirect_to :tasks #指定のビューへ転送
    else
      render "edit" #指定のビューを再描写？
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    flash[:dlt] = "スケジュールを削除しました"
    redirect_to :tasks
  end

  private

  def task_params
    params.require(:task).permit(:title, :date_start, :date_end, :is_allday, :memo)
  end
end
