class AuthenticationsController < ApplicationController
	def create
		#binding.pry
		auth = request.env["omniauth.auth"]
		user = User.from_omniauth(auth)
		sign_in(user)
		#current_user.authentications.find_or_create_by_provider_and_uid(auth['provider'], auth['uid'])
		flash[:notice] = "Authentication successful."
		redirect_to root_url
	end
end
