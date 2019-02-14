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
  end

  def create
    @account_data = AccountData.new(account_data_params)
    if @account_data.valid?
      account_data = convert_to_post_data(@account_data)
      @access_token.post("#{API_URL}home/money/payment", account_data)
      response_message(@access_token)
    else
      flash[:alert] = "Input value is incorrect."
    end
		redirect_to account_books_path
  end

  def destroy
    @access_token.delete("#{API_URL}home/money/payment/#{params["id"]}")
    response_message(@access_token)
    redirect_to account_books_path
  end

  private

  def account_data_params
    params.require(:account_data).permit(:category_id, :genre_id,:amount,:date, :comment, :name, :place)
  end

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

  def convert_to_post_data(data)
      post_data = {
        "mapping"     => 1,
        "category_id" => data.category_id,
        "genre_id"    => data.genre_id,
        "name"        => data.name,
        "amount"      => data.amount,
        "date"        => data.date,
        "comment"     => data.comment,
        "place"       => data.place
      }
  end

  def response_message(access_token)
    if access_token.response.class == Net::HTTPOK
      flash[:success] = "#{self.action_name} account record is successful."
    else
      flash[:alert] = access_token.response
    end
  end

end
