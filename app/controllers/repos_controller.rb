class ReposController < ApplicationController
	def index
		#binding.pry
		#@repos = Repo.all
    @repos = Repo.create_repo(current_user)
    project_commit_graph
  end

  def show
  	#binding.pry
   @repo = Repo.find_by(id: params["id"])
   @notification = Repo.fetch_notifications(@repo.id)
   @user_wise_notifications =  @notification.group_by{|x| x.commiter_name}
   
  end
 
  def project_commit_graph
    #binding.pry
    @repo = current_user.repos
    @repo_wise_lables = []
    @repo_data = []
    @repo.each do |repo|
      @repo_wise_lables << repo["github_repo_name"]
      @repo_data << repo.notifications.count
    end
    
  end

=begin
    def chart_data
    hash = {}
    @repo_wise_lables.each do|key|
      hash[key] = 0
    end 
=end

  
  
end
