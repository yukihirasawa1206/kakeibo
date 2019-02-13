class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	CONSUMER_KEY = ENV['CONSUMER_KEY']
	CONSUMER_SECRET = ENV['CONSUMER_SECRET']
	CALLBACK_URL = ENV['CALLBACK_URL']
	API_URL = 'https://api.zaim.net/v2/'

	def authenticated_user
		return if session[:request_token] && session[:request_secret]
		redirect_to root_path
		flash[:alert] = "Sign in is required."
	end

end
