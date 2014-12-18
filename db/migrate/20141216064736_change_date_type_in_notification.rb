class ChangeDateTypeInNotification < ActiveRecord::Migration
  def up
  	change_column :notifications, :commit_date, :datetime 
  end
  def down
  	change_column :notifications, :commit_date, :date
  end
end
