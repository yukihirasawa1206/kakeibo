class AccountBooksController < ApplicationController
	before_action :authenticated_user
	before_action :set_consumer, only: [:index, :create, :destroy]
	before_action :set_access_token, only: [:index, :create, :destroy]

	def index
		payment_records_json = @access_token.get("#{API_URL}home/money")
		@payment_records = JSON.parse(payment_records_json.body)["money"]
		user_json = @access_token.get("#{API_URL}home/user/verify")
		@user = JSON.parse(user_json.body)["me"]
		@account_data = AccountData.new
		category_list
	end

	def create
		@account_data = AccountData.new(account_data_params)
		if @account_data.valid?
			account_data = {
				"mapping"     => 1,
				"category_id" => @account_data.category_id,
				"genre_id"    => @account_data.genre_id,
				"name"        => @account_data.name,
				"amount"      => @account_data.amount,
				"date"        => @account_data.date,
				"comment"     => @account_data.comment,
				"place"       => @account_data.place
			}
			@access_token.post("#{API_URL}home/money/payment", account_data)
		else
			flash[:alert] = "Something went wrong."
		end
		redirect_to account_books_path
	end

	def destroy
		@access_token.delete("#{API_URL}home/money/payment/#{params["id"]}")
		redirect_to account_books_path
		flash[:alert] = "Delete account record is successful."
	end

	private

	def authenticated_user
		return if session[:request_token] && session[:request_secret]
		redirect_to root_path
		flash[:alert] = "Sign in is required."
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
		if session[:categories]
			@categories_convert_hash = session[:categories]
		else
			categories_format_json = HTTPClient.get("#{API_URL}category").body
			categories_convert_array = JSON.parse(categories_format_json)["categories"]
			@categories_convert_hash = Hash[*(categories_convert_array.map{|category|category.values[0,2]}.flatten)]
			session[:categories] = @categories_convert_hash
		end
	end

	def account_data_params
		params.require(:account_data).permit(:category_id, :genre_id,:amount,:date, :comment, :name, :place)
	end

end
