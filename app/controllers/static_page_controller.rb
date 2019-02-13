class StaticPageController < ApplicationController

	def top
		redirect_to account_books_path if session[:request_token] && session[:request_secret]
	end

end
