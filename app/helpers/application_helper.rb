module ApplicationHelper

	def signin_user?
		if session[:request_token] && session[:request_secret]
			true
		end
	end

	def set_yyyy_mm
		"#{Date.today.year}-#{Date.today.month}"
	end

	def sum_month_payment(payment_records)
		present_month_records = []
		payment_records.each do |payment_record|
			first_date = Date.new(Date.today.year, Date.today.month, 1).to_s
			if payment_record["date"] >= first_date
				present_month_records << payment_record["amount"]
			end
		end
			number_to_currency(present_month_records.sum, unit: "￥", precision: 0)
	end

end
