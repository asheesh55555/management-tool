class HomeController < ApplicationController
	def index
		
	end
	def add_member_to_team_form
	    @teams	=Team.all
	    @users =  User.all
	end

	def add_member_to_team
		if params[:member].present?
		User.find(params[:member]).update(team_id: params[:team])
	end
		@teams	=Team.all
	end

	def team_and_members
		@teams	=Team.all
	end
	def assign_project_form
		 @teams	=Team.all
         @projects =Project.all
	end

	def assign_project_submit
		@teams	=Team.all
		if ProjectTeam.where(team_id: params[:team], project_id: params[:project]).first.present?
			flash[:notice] = "This Project already assingned to this Team."
		else
			ProjectTeam.create(team_id: params[:team], project_id: params[:project])
		end
		
		
	end

	def assigned_project_to_team
		@teams	=Team.all
	end
	def assign_project_to_team_member_form
        @team = Team.find(params[:team])    
	end
	def assign_project_to_team_member_submit
		@user = User.find(params[:user])
		@project = Project.find(params[:project])
		@tasks=MemberTask.where(team_id: User.find(params[:user]).team.id,  user_id: params[:user], project_id: params[:project])

		if UserProject.where(user_id: params[:user], project_id: params[:project]).first.present?
            flash[:notice] = "This Project already assingned to this member please assign task."

		else
		   UserProject.create(user_id: params[:user], project_id: params[:project])
            flash[:notice] = "Project assigned."
		end
	end
	def project_task_submit
		if params[:task].present?
		   MemberTask.create(team_id: params[:team],  user_id: params[:user], project_id: params[:project], task_id: params[:task])
	    end

		@user = User.find(params[:user])
		@project = Project.find(params[:project])
		@tasks=MemberTask.where(team_id: params[:team],  user_id: params[:user], project_id: params[:project])

	end
	def all_assigned_task
		
	end

	def all_assigned_task_user
		
	end
end
