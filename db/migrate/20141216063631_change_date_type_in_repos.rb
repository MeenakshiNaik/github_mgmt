class ChangeDateTypeInRepos < ActiveRecord::Migration
  def up
  	change_column :notifications, :commit_date, :date 
  end
  def down
  	change_column :notifications, :commit_date, :string
  end
end
