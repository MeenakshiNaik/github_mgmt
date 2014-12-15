class ChangeDescTypeInRepos < ActiveRecord::Migration
   def up
    change_column :repos, :github_repo_description, :text ,:limit => nil
  end

  def down
    change_column :repos, :github_repo_description, :string
  end
end
