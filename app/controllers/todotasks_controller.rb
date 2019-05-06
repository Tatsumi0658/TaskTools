class TodotasksController < ApplicationController
  before_action :set_task, only:[:edit, :destroy, :show, :update]

  def index
    if current_user.present?
      @todotasks = Todotask.where(user_id: current_user.id)
      if params[:todotask].present? && params[:todotask][:search_flag]
        if params[:todotask][:name].present? && params[:todotask][:status].present? && params[:todotask][:label_ids].present?
          label = TaskLabel.where(label_id: params[:todotask][:label_ids]).pluck(:todotask_id)
          @todotasks = @todotasks.search_name(params[:todotask][:name]).search_status(params[:todotask][:status])
          @todotasks = @todotasks.where(id: label).page params[:page]
        elsif params[:todotask][:name].present? && params[:todotask][:status].present?
          @todotasks = @todotasks.search_name(params[:todotask][:name]).search_status(params[:todotask][:status]).page params[:page]
        elsif params[:todotask][:status].present? && params[:todotask][:label_ids].present?
          label = TaskLabel.where(label_id: params[:todotask][:label_ids]).pluck(:todotask_id)
          @todotasks = @todotasks.search_status(params[:todotask][:status])
          @todotasks = @todotasks.where(id: label).page params[:page]
        elsif params[:todotask][:name].present? && params[:todotask][:label_ids].present?
          label = TaskLabel.where(label_id: params[:todotask][:label_ids]).pluck(:todotask_id)
          @todotasks = @todotasks.search_name(params[:todotask][:name])
          @todotasks = @todotasks.where(id: label).page params[:page]
        elsif params[:todotask][:name].present?
          @todotasks = @todotasks.search_name(params[:todotask][:name]).page params[:page]
        elsif params[:todotask][:status].present?
          @todotasks = @todotasks.search_status(params[:todotask][:status]).page params[:page]
        elsif params[:todotask][:label_ids].present?
          label = TaskLabel.where(label_id: params[:todotask][:label_ids]).pluck(:todotask_id)
          @todotasks = @todotasks.where(id: label).page params[:page]
        else
          redirect_to todotasks_path
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
    @labels = Label.all

    if current_user.present?
      @warntasks = Todotask.where(user_id: current_user.id).where(status: 1..2).order("deadline asc")
      @time = Time.current
      @count = 0
      @warntasks.each do |warn|
        if ( (warn.deadline - @time) / (24*60*60) ) <= 1
          @count = +1
        end
      end
    end

    if current_user.present?
      @calender_tasks = Todotask.where(user_id: current_user.id)
      hash = {}
      @labels.each do |label|
        size = TaskLabel.where(label_id: label.id).count
        hash.store(label.name,size)
      end
      @graph_data = hash
    end
  end

  def new
    @todotask = Todotask.new
    @labels = Label.all
    3.times { @uploadfiles = @todotask.taskfiles.build }
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
    @labels = Label.all
    #3.times { @uploadfiles = @todotask.taskfiles.build }
  end

  def show
    @tasklabels = TaskLabel.where(todotask_id: @todotask.id).all
    if current_user.id == @todotask.user_id
      @todotask.read = true
      @todotask.save
    end
    @uploadfiles = @todotask.taskfiles
  end

  def update
    if @todotask.user_id == current_user.id
      if @todotask.update(todotask_params)
        redirect_to todotasks_path
        flash[:success] = t('.success')
      else
        render :edit
        flash[:danger] = t('.failed')
      end
    else
      redirect_to todotask_path(@todotask.id)
      flash[:danger] = t('.failed')
    end
  end

  def destroy
    if @todotask.user_id == current_user.id
      @todotask.destroy
      redirect_to todotasks_path
      flash[:danger] = t('.success')
    else
      redirect_to todotask_path(@todotask.id)
      flash[:danger] = t('.failed')
    end
  end

  private
  def set_task
    @todotask = Todotask.find(params[:id])
  end

  def todotask_params
    params.require(:todotask).permit(:name, :content, :status, :deadline, :priority, taskfiles_attributes: [:uploadfiles], label_ids: [])
  end
end
