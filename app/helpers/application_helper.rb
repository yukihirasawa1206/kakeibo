module ApplicationHelper

  CATEGORY_LIST = {
    "11"=>"Salary",
    "12"=>"Advances repayment",
    "13"=>"Bonus",
    "14"=>"Extraordinary revenue",
    "15"=>"Business income",
    "19"=>"Other",
    "101"=>"Food",
    "102"=>"Daily goods",
    "103"=>"Transport",
    "104"=>"Phone, Net",
    "105"=>"Utilities",
    "106"=>"Home",
    "107"=>"Socializing",
    "108"=>"Hobbies",
    "109"=>"Education",
    "110"=>"Medical",
    "111"=>"Fashion",
    "112"=>"Automobile",
    "113"=>"Taxes",
    "114"=>"Big outlay",
    "199"=>"Other"}

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
