#APP_CONFIG =  (YAML.load_file(File.join(Rails.root, "config/app_config.yml"))[Rails.env])

Rails.application.config.middleware.use OmniAuth::Builder do
	OmniAuth.config.logger = Rails.logger
  provider :github, '9685a50546581389de28', '3c66390ff17686e594367f91de99b539f2e9f986',scope: "user,repo,gist"
   #on_failure { |env| AuthenticationsController.action(:failure).call(env) }
end
