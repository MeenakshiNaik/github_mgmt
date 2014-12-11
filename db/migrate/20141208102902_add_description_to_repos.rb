class AddDescriptionToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :github_repo_description, :string
  end
end
