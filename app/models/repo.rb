class Repo < ActiveRecord::Base

	belongs_to :user
	has_many :notifications
	validates :github_repo_name ,presence: true
	validates :github_repo , presence: true

	def self.create_or_retirve_github_repo(user)
		binding.pry
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

	def self.fetch_notifications(repo_id)
		Notification.where(repo_id: repo_id)
	end

	def self.user_wise_commit_graph(repo_id)
		repo = Repo.find_by(id: repo_id)
		days_from_this_week = (7.days.ago.to_date..Date.today).collect{|day| day} 
		days_hash = {}
		
		days_from_this_week.inject([]){|key ,day| days_hash[day] = []}

		day_wise_commit = repo.notifications.group_by{|commit| commit.commit_date.to_date} 
		days_hash.each_key do |day_name|
			day_wise_commit.each do |day , commit|
				if day == day_name
					days_hash[day_name] = commit
				end
			end
		end

		commiters_for_repo = repo.notifications.map(&:commiter_name).uniq
		commiter_wise_series_data = {}
		commiters_for_repo.each do |commiter|
			commiter_wise_series_data[commiter.to_s.intern] = days_hash.values.map{|commits| commits.select{|commit| commit.commiter_name == commiter}.count }
		end
		series_data = [] 
		commiter_wise_series_data.map{|commiter_name , commits| series_data.push({name: commiter_name, data: commits})}
		series_data
	end

	def self.project_commit_graph(user)
		repo = user.repos
		repo_wise_lables = []
		repo_data = []
		repo.each do |repo|
			repo_wise_lables << repo.github_repo_name
			repo_data << repo.notifications.count
		end
		graph_data = [repo_wise_lables,repo_data]
		graph_data
	end
end
