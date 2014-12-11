class CreateRepos < ActiveRecord::Migration
  def change
    create_table :repos do |t|
      t.string :github_repo_name
      t.string :github_repo
      t.integer :github_repo_id

      t.timestamps
    end
  end
end
