class ProjectsController < ApplicationController
  load_and_authorize_resource except: [:create]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_filter :right_owner, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    if current_user.role == "Administrator"
      @projects = Project.all
    else
      @projects = current_user.projects
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Проект успешно создан!' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Проект успешно изменен.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :user_id)
    end

    def right_owner
      @project = Project.find(params[:id])
      unless current_user.role == "Administrator"
        unless @project.user_id == current_user.id
          redirect_to(projects_url)
          flash[:error] = "Доступ запрещен."
        end
      end
    end
end
