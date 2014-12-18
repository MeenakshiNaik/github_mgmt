class GithubNotification
	attr_accessor :params,:repo

	def initialize(repo,params)
		@params = params
		@repo = repo
	end

  def update_commits_for_repo
		if @params[:commits].present?
			@params[:commits].each do |commit|
				@repo.notifications.create(commit: commit["url"],commiter_name: commit[:committer][:username],commit_date: DateTime.parse(commit[:timestamp]) ,commit_message: commit["message"])
			end
		end
	end
end