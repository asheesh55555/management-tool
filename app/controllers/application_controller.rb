class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_permission, only: [:new, :edit, :update, :destroy]


  private
    def set_permission
      if !ApplicationAuthorizer.creatable_by?(current_user)
        redirect_to root_path, notice: 'You are not Authorize.' 
      end
    end
end
