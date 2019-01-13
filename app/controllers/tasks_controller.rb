class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks=Task.all
  end
  def new
    @task=Task.new
  end
  def create
    @task=Task.new(task_params)
    
    if @task.save
      flash[:success]='Taskが正常に登録されました'
      redirect_to @task
    else 
      flash.now[:danger]='Taskは登録されませんでした'
      render :new
    end
  end
  def destroy
    
    @task.destroy
    
    flash[:success]='削除されました'
    redirect_to tasks_url
  end
  def edit
    
  end
  def update
    
    
    if @task.update(task_params)
      flash[:success]='Taskが正常に更新されました'
      redirect_to @task
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
end
