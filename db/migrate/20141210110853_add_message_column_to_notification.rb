class AddMessageColumnToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :commit_message, :string
  end
end
