Rails.application.routes.draw do
  
  
  resources :clients
  resources :technologies
  resources :teams do
    member do
      get :assign_project
      post :assigned_project
      get :assign_member
      post :assigned_member
      get :assign_member_project
      post :assigned_member_project
      post :assigned_member_project_task

    end
  end
  resources :projects do
       resources :tasks do
            resources :dependencies
       end
  end
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root to: "home#dashboard"
get 'add/member', :to => 'home#add_member_to_team_form'
post 'submit/member', :to => 'home#add_member_to_team'
get 'team/members', :to => 'home#team_and_members'
get 'assign/project', :to => 'home#assign_project_form'
post 'assign/project/submit', :to => 'home#assign_project_submit'
get 'assigned/project', :to => 'home#assigned_project_to_team'
get 'assign/project/team_member', :to => 'home#assign_project_to_team_member_form'
post 'assign/project/team_member/submit', :to => 'home#assign_project_to_team_member_submit'

post 'project/task/submit', :to => 'home#project_task_submit'
get 'all/assigned_task', :to => 'home#all_assigned_task'
get 'all/assigned/task/user', :to => 'home#all_assigned_task_user'







end
