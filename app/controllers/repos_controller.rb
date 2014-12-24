class ReposController < ApplicationController

  def index
    @repos = Repo.create_or_retrive_github_repo(current_user)
    @label,@project_series_data = Repo.project_commit_graph(current_user)
  end

  def show
    @repo = Repo.find_by(github_repo_name: params["id"])
    if @repo.present?
      @notifications = @repo.notifications
      @days_from_this_week = (7.days.ago.to_date..Date.today).map{|d| d.strftime("%d%b%Y")} 
      @series_data = @repo.user_wise_commit_graph
      @user_wise_notifications =  @notifications.group_by{|commiter| commiter.commiter_name}
    else
      render :file => "#{Rails.root}/public/404.html",  :status => 404
    end
    
  end
end
