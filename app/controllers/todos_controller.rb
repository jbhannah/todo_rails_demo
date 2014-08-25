class TodosController < ApplicationController
  load_and_authorize_resource

  # GET /todos
  # GET /todos.json
  def index
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    params[:todo] = params["todo_" + params[:id].to_s]
    @todo.user = current_user

    if @todo.save
      @status  = "success"
      @message = "To-do created successfully."
      unless request.xhr?
        flash[:notice] = @message
        redirect_to action: :index
      else
        render @todo
      end
    else
      @status  = "alert"
      @message = "To-do could not be created."
      unless request.xhr?
        flash[:alert] = @message
        redirect_to :back
      else
        render @todo
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    params[:todo] = params["todo_" + params[:id].to_s]

    if @todo.update(update_params)
      @status  = "success"
      @message = "To-do updated successfully."
      unless request.xhr?
        flash[:notice] = @message
        redirect_to action: :index
      end
    else
      @status  = "alert"
      @message = "To-do could not be updated."
      unless request.xhr?
        flash[:alert] = @message
        redirect_to :back
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    if @todo.destroy
      flash[:notice] = "To-do destroyed successfully."
      redirect_to action: :index
    else
      flash[:alert] = "To-do could not be destroyed."
      redirect_to :back
    end
  end

  private
  def create_params
    params.require(:todo).permit(:name)
  end

  def update_params
    if current_user.is_admin?
      params.require(:todo).permit(:name, :completed)
    else
      params.require(:todo).permit(:completed)
    end
  end
end
