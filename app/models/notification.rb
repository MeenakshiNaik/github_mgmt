class Notification < ActiveRecord::Base
	belongs_to  :user
	validates :commiter_name, presence: true
	validates :commit, presence: true
end
