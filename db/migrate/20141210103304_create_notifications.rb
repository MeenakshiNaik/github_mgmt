class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :repo_id
      t.string :commit
      t.string :commiter_name
      t.string :commit_date

      t.timestamps
    end
  end
end
