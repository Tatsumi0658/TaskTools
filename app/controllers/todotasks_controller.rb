class TodotasksController < ApplicationController
  before_action :set_task, only:[:edit, :destroy, :show, :update]
  def index
    @todotasks = Todotask.all
  end

  def new
    @todotask = Todotask.new
  end

  def create
    @todotask = Todotask.new(todotask_params)
    @todotask.deadline = Date.new(todotask_params["deadline(1i)"].to_i, todotask_params["deadline(2i)"].to_i, todotask_params["deadline(3i)"].to_i)
    if @todotask.save
      redirect_to todotasks_path
      flash[:success] = "タスクを作成しました"
    else
      render :new
      flash[:warning] = "タスクの作成に失敗しました"
    end
  end

  def edit
  end

  def show
  end

  def update
    if @todotask.update(todotask_params)
      redirect_to tasks_path
      flash[:success] = "タスクを更新しました"
    else
      render :edit
    end
  end

  def destroy
    @todotask.destroy
    redirect_to tasks_path
    flash[:success] = "削除しました"
  end

  private
  def set_task
    @todotask = Todotask.find(params[:id])
  end

  def todotask_params
    params.require(:todotask).permit(:name, :status, :deadline, :priority)
  end
end
