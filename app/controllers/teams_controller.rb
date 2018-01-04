class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy, :assign, :assigned]
  before_action :set_permission, only: [:new, :edit, :update, :destroy]


  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def assign
    @projects = Project.all
  end

  def assigned
    projects = params[:assign_project][:project_id]-[""]
    @team.projects.destroy_all
    projects.each do |project_id|
      ProjectTeam.create(team_id: params[:assign_project][:team_id], project_id: project_id)
      flash[:notice] = "This Project assingned to this Team successfully"
    end
    redirect_to team_path()
  end


  private

   def set_permission
      if !ApplicationAuthorizer.creatable_by?(current_user)
        redirect_to root_path, notice: 'You are not Authorize.' 
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name)
    end

    def assign_params
      params.require(:assign_project).permit(:project_id, :team_id)
    end
end
