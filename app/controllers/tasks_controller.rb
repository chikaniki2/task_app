class TasksController < ApplicationController
  def index
    @tasks = Task.all # allメソッドはtasksテーブルのレコードを全て取得できるメソッド
    #@posts = Post.all # 別DBを追加で扱う場合は随時追加。例ではPostsモデル。
    taskcount = @tasks.size
    flash.now[:taskcount] = "  スケジュール合計#{taskcount}件" # kensuusyutoku
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title, :date_start, :date_end, :is_allday, :memo))
    if @task.save
	    flash[:notice] = "スケジュールを新規登録しました"
	    redirect_to :tasks
	  else
	    render "new"
	  end
  end
 
  def show
    @task = Task.find(params[:id]) #params はGETで取得した値。task.find(1)などになる。単体レコードの抽出。
    #@post = Post.new
    #@posts = @task.posts #リレーションを定義することでこのような記述が可能
    ##@posts = Post.where(task_id: @task.id) #この記述でも実装できる
  end
 
  def edit
    @task = Task.find(params[:id])
  end
 
  def update
    @task = Task.find(params[:id])
      if @task.update(params.require(:task).permit(:title, :date_start, :date_end, :is_allday, :memo)) #パワーパラメータ。DBへのインジェクションを防げる。
        flash[:notice] = "スケジュールID「#{@task.id}」の情報を更新しました" #フラッシュメッセージ
        redirect_to :tasks #指定のビューへ転送
      else
        render "edit" #指定のビューを再描写？
      end
  end
 
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:dlt] = "スケジュールを削除しました"
    redirect_to :tasks
  end
end