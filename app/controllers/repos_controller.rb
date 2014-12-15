class ReposController < ApplicationController
	def index
		#binding.pry
		#@repos = Repo.all
    @repos = Repo.create_repo(current_user)
  end

  def show
  	#binding.pry
   @repo = Repo.find_by(id: params["id"])
   @notification = Repo.fetch_notifications(@repo.id)
   @user_wise_notifications =  @notification.group_by{|x| x.commiter_name}
   
  end

  
end
