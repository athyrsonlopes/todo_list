class TasksController < ApplicationController
  include Exportable

  before_action :set_task, only: %i[ edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.only_parents.order(:due_date)
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_paths, notice: "Tarefa foi criada com sucesso." }
        format.json { render :show, status: :created, location: @task }
      else
        flash.now[:alert] = @task.errors.full_messages.to_setence
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @task.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "Tarefa foi atualizada com sucesso.", status: :see_other }
        format.json { render :show, status: :ok, location: @task }
      else
        flash.now[:alert] = @task.errors.full_messages.to_setence
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @task.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to tasks_path, notice: "Tarefa removida com sucesso.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :description, :due_date, :done, :parent_id ])
    end
end
