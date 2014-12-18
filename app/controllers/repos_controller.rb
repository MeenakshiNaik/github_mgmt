class ReposController < ApplicationController

  def index
    @repos = Repo.create_or_retrive_github_repo(current_user)
    @user_repos = Repo.fetch_github_repo(current_user).group_by{|repo| repo["owner"]["login"]}
    @label , @data = Repo.project_commit_graph(current_user)
  end

  def show
    @repo = Repo.find_by(github_repo_name: params["id"])
    @notifications = @repo.notifications
    @days_from_this_week = (7.days.ago.to_date..Date.today).map{|d| d.strftime("%d%a%Y")} 
    @series_data = @repo.user_wise_commit_graph
    @user_wise_notifications =  @notifications.group_by{|x| x.commiter_name}
  end
end
