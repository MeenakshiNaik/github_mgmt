class ReposController < ApplicationController

  def index
    @repos = Repo.create_or_retirve_github_repo(current_user)
    @user_repos = Repo.fetch_github_repo(current_user).group_by{|repo| repo["owner"]["login"]}
    @label , @data = Repo.project_commit_graph(current_user)
  end

  def show
    @repo = Repo.find_by(github_repo_name: params["id"])
    @notification = Repo.fetch_notifications(@repo.id)
    @days_from_this_week = (7.days.ago.to_date..Date.today).map{|d| d.strftime("%a")} 
    @series_data = Repo.user_wise_commit_graph(@repo.id)
    @user_wise_notifications =  @notification.group_by{|x| x.commiter_name}
  end
end
