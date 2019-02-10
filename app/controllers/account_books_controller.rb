class AccountBooksController < ApplicationController
	before_action :authenticated_user?
	before_action :set_consumer, only: [:index, :create, :destroy]
	before_action :set_access_token, only: [:index, :create, :destroy]

	def index
		payment_records_json = @access_token.get("#{API_URL}home/money")
		@payment_records = JSON.parse(payment_records_json.body)["money"]
		user_json = @access_token.get("#{API_URL}home/user/verify")
		@user = JSON.parse(user_json.body)["me"]
		binding.pry
	end

	def create
		account_data = {"mapping" => 1,
									 "category_id" => params["category_id"],
									 "genre_id" => params["genre_id"],
									 "name" => params["name"],
									 "amount" => params["amount"],
									 "comment" => params["comment"],
									 "date" => Date.today.to_s
		}
		@access_token.post("#{API_URL}home/money/payment", account_data)
		redirect_to account_books_path
	end

	def destroy
		@access_token.delete("#{API_URL}home/money/payment/#{params["id"]}")
		redirect_to account_books_path
	end

	private

	def authenticated_user?
		return if session[:request_token] && session[:request_secret]
		redirect_to root_path
	end

	def set_consumer
		@consumer = OAuth::Consumer.new(
			CONSUMER_KEY,
			CONSUMER_SECRET,
			site: 'https://api.zaim.net',
			request_token_path: '/v2/auth/request',
			authorize_url: 'https://auth.zaim.net/users/auth',
			access_token_path: '/v2/auth/access')
	end

	def set_access_token
		@access_token = OAuth::AccessToken.new(@consumer, session[:access_token], session[:access_secret])
	end

	def category_list
		categories_format_json = HTTPClient.get("#{API_URL}category").body
		categories_convert_array = JSON.parse(categories_format_json)["categories"]
		@categories_convert_hash = Hash[*(categories_convert_array.map{|category|category.values[0,2]}.flatten)]
	end

end
