class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:update,:edit]

  def index
    @tasks=Task.all
  end
  def new
    @task=Task.new
  end
  def create
    @task=current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success]='Taskが正常に登録されました'
      redirect_to root_url
    else 
      @tasks=current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger]='Taskは登録されませんでした'
      render 'toppages/index'
    end
  end
  def destroy
    
    @task.destroy
    
    flash[:success]='削除されました'
    redirect_back(fallback_location: root_path)
  end
  def edit
    
  end
  def update
    
    
    if @task.update(task_params)
      flash[:success]='Taskが正常に更新されました'
      redirect_to "/"
    else 
      flash.now[:danger]='Taskは更新されませんでした'
      render :edit
    end
  end
  def show
    
  end
  
  private
  
  def set_task
    @task=Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:status,:content)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
