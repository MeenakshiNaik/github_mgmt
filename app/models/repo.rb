class Repo < ActiveRecord::Base

	belongs_to :user
	has_many :notifications
  has_many :webhooks
	validates :github_repo_name ,presence: true
	validates :github_repo , presence: true

	def self.create_or_retrive_github_repo(user)
		git_repos = Repo.fetch_github_repo(user)
		git_repos.each do |repo|
			new_repo = Repo.find_by(github_repo_id: repo["id"])
			unless new_repo.present?
				new_repo = user.repos.create(github_repo_name: repo["name"],github_repo: repo["html_url"],github_repo_id: repo["id"] ,github_repo_description: repo["description"])
			end
		end
	end

	def self.fetch_github_repo(user)
		begin
			Github.repos.list user: user.name
		rescue
			user.repos
		end
	end

	# def user_wise_commit_graph
	# 	days_from_this_week = (7.days.ago.to_date..Date.today).collect{|day| day} 
	# 	days_hash = {}
		
	# 	days_from_this_week.inject([]){|key ,day| days_hash[day] = []}

	# 	day_wise_commit = self.notifications.group_by{|commit| commit.commit_date.to_date} 
	# 	days_hash.each_key do |day_name|
	# 		day_wise_commit.each do |day , commit|
	# 			days_hash[day_name] = commit if day == day_name
	# 		end
	# 	end
	# 	commiters_for_repo = self.notifications.map(&:commiter_name).uniq
	# 	if commiters_for_repo.present?
	# 		commiter_wise_series_data = {}
	# 		commiters_for_repo.each do |commiter|
	# 			commiter_wise_series_data[commiter.to_s.intern] = days_hash.values.map{|commits| commits.select{|commit| commit.commiter_name == commiter}.count }
	# 		end
	# 		commiter_wise_series_data.map{|commiter_name , commits| ({name: commiter_name, data: commits})}
	# 	else
	# 		[{name: "No commits", data: [0,0,0,0,0,0,0,0]}]
	# 	end
	# end

	# def self.project_commit_graph(user)
	# 	repos = user.repos
	# 	[repos.map(&:github_repo_name),[{name: "commits", data: repos.map(&:notifications).map(&:count)}]]
	# end

	def self.search(search , current_user)
		if search.present?
			Repo.create_or_retrive_github_repo(current_user).select{|repo| repo[:name].include?("#{search}")}
		else
			Repo.create_or_retrive_github_repo(current_user)
		end
	end
end
