#APP_CONFIG =  (YAML.load_file(File.join(Rails.root, "config/app_config.yml"))[Rails.env])
Rails.application.config.middleware.use OmniAuth::Builder do
	OmniAuth.config.logger = Rails.logger
  provider :github, APP_CONFIG['github_client_id'], APP_CONFIG['github_client_secret'], provider_ignores_state: true ,scope: "user,repo,gist,user:email,read:repo_hook,write:repo_hook,admin:repo_hook,admin:org_hook"
   #on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end
