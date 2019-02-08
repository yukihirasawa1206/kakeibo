class AccountBooksController < ApplicationController

	def index
		payment_records_json = @access_token.get("#{API_URL}home/money")
		@payment_records = JSON.parse(payment_record_json.body)
		binding.pry
	end

	def create
	end

	def destroy
	end

end
