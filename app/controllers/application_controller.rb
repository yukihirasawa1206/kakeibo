class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	CONSUMER_KEY = ENV['CONSUMER_KEY']
	CONSUMER_SECRET = ENV['CONSUMER_SECRET']
	CALLBACK_URL = ENV['CALLBACK_URL']
	API_URL = 'https://api.zaim.net/v2/'
end
