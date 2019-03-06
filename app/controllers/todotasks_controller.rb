class TodotasksController < ApplicationController
  before_action :set_task, only:[:edit, :destroy, :show, :update]

  def index
    if current_user.present?
      @todotasks = Todotask.where(user_id: current_user.id)
      if params[:todotask].present? && params[:todotask][:search_flag]
        if params[:todotask][:name] && params[:todotask][:status].blank?
          @todotasks = @todotasks.search_name(params[:todotask][:name]).page params[:page]
        elsif params[:todotask][:name].blank? && params[:todotask][:status]
          @todotasks = @todotasks.search_status(params[:todotask][:status]).page params[:page]
        elsif params[:todotask][:name] && params[:todotask][:status]
          @todotasks = @todotasks.search_name(params[:todotask][:name]).search_status(params[:todotask][:status]).page params[:page]
        end
      elsif params[:sort_expired].present?
        @todotasks = @todotasks.all.order('deadline desc').page params[:page]
      elsif params[:priority_sort_expired].present?
        @todotasks = @todotasks.all.order('priority asc').page params[:page]
      else
        @todotasks = @todotasks.all.order('created_at desc').page params[:page]
      end
    else
      redirect_to new_session_path
    end
  end

  def new
    @todotask = Todotask.new
    @todotask.labels.build
    @labels = Label.all
  end

  def create
    @todotask = Todotask.new(todotask_params)
    @todotask.user_id = current_user.id
    @todotask.deadline = Date.new(todotask_params["deadline(1i)"].to_i, todotask_params["deadline(2i)"].to_i, todotask_params["deadline(3i)"].to_i)
    if @todotask.save
      redirect_to todotasks_path
      flash[:success] = t('.success')
    else
      render :new
      flash[:warning] = t('.failed')
    end
  end

  def edit
  end

  def show
  end

  def update
    if @todotask.update(todotask_params)
      redirect_to todotasks_path
      flash[:success] = t('.success')
    else
      render :edit
      flash[:danger] = t('.failed')
    end
  end

  def destroy
    @todotask.destroy
    redirect_to todotasks_path
    flash[:danger] = t('.success')
  end

  private
  def set_task
    @todotask = Todotask.find(params[:id])
  end

  def todotask_params
    params.require(:todotask).permit(:name, :content, :status, :deadline, :priority, labels_attributes:[label_ids:[]])
  end
end
