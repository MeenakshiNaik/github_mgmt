class CreateWebhooks < ActiveRecord::Migration
  def change
    create_table :webhooks do |t|
      t.integer :repo_id
      t.integer :hook_id
      t.string :name
      t.string :hook_url

      t.timestamps
    end
  end
end
