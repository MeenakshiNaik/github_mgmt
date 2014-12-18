class HomesController < ApplicationController

	skip_before_action :verify_authenticity_token ,:only => [:payload]
	def payload
		puts params
		@repo = Repo.find_by(github_repo_id: params["repository"]["id"])

		if params[:commits].present?
			params[:commits].each do |commit|
				@repo = Repo.where("github_repo = ?",params[:repository][:html_url]).last
				@note = @repo.notifications.create(commit: commit["url"],commiter_name: commit[:committer][:username],commit_date: DateTime.parse(commit[:timestamp]) ,commit_message: commit["message"])
			end
		end
		respond_to do |format|
			format.json { head :ok }
		end
	end 
end
