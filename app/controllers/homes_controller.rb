class HomesController < ApplicationController
	
	skip_before_action :verify_authenticity_token ,:only => [:payload]
	def payload
		#binding.pry
  	puts params
  	@repo = Repo.find_by(github_repo_id: params["repository"]["id"])

=begin
unless @repo.present?
			@repo = Repo.create(github_repo_name: params["repository"]["name"],github_repo: params["repository"]["html_url"],github_repo_id: params["repository"]["id"] ,github_repo_description: params["repository"]["description"])
      
		end
=end


  if params[:commits].present?
    params[:commits].each do |commit|
      @repo = Repo.where("github_repo = ?",params[:repository][:html_url]).last
    	@note = Notification.create(commit: commit["url"],commiter_name: commit[:committer][:username],commit_date: commit[:timestamp].to_date ,commit_message: commit["message"])
      @repo.notifications << @note
          
    end
  end


  	respond_to do |format|
      format.json { head :ok }
    end
  end 
end
