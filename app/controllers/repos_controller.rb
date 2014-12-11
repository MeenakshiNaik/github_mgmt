class ReposController < ApplicationController
	def index
		#binding.pry
		#@repos = Repo.all
    @repos = Repo.create_repo(current_user)
   
=begin
    @git_repos = Github.repos.list user: current_user.name
    @git_repos.each do |repo|
      @new_repo = Repo.find_by(github_repo_id: repo["id"])
      unless @new_repo.present?
        @new_repo = Repo.create(github_repo_name: repo["name"],github_repo: repo["html_url"],github_repo_id: repo["id"] ,github_repo_description: repo["description"])
      end
      current_user.repos << @new_repo
    end
=end
  end

  def show
  	#binding.pry
   @repo = Repo.find_by(github_repo_id: params["id"])
   @notification = Repo.fetch_notifications(@repo.id)
  end

  
end
