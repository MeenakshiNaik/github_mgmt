class HomesController < ApplicationController

  skip_before_action :verify_authenticity_token ,:only => [:payload]
  def payload
    repo = Repo.find_by(github_repo_id: params["repository"]["id"])
    if repo.present?
      GithubNotification.new(repo,params).update_commits_for_repo
    end

    respond_to do |format|
      format.json { head :ok }
    end
  end 
end
