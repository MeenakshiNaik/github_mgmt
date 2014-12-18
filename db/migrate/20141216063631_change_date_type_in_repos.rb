class ChangeDateTypeInRepos < ActiveRecord::Migration
  def up
  	#change_column :notifications, :commit_date, :date 
  	connection.execute(%q{
    	alter table notifications
    	alter column commit_date
    	type timestamp using cast(commit_date as timestamp)
  	})
  end
  def down
  	change_column :notifications, :commit_date, :string
  end
end
