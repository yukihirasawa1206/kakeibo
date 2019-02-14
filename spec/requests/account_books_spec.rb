require 'rails_helper'
require 'webmock/rspec'

RSpec.describe "AccountBooks", type: :request do

  describe "should be able to redirect to the index page" do

    before do
      allow_any_instance_of(AccountBooksController).to receive(:authenticated_user)
      WebMock.enable!
      WebMock.stub_request(:get, 'https://api.zaim.net/v2/home/money').to_return(
        body: JSON.parse(File.read("#{Rails.root}/spec/fixtures/stub_api_response.json")),
        status: 200,
        headers: { 'Content-Type'=> 'application/json' })
      WebMock.stub_request(:get, 'https://api.zaim.net/v2/home/user/verify').to_return(
        body: JSON.parse(File.read("#{Rails.root}/spec/fixtures/stub_api_user.json")),
        status: 200,
        headers: { 'Content-Type'=> 'application/json' })
    end

    it "should respond 200 status" do
      get account_books_path
      expect(response).to have_http_status(200)
    end

  end

  describe "should be redirect to #index after post account data" do
    before do
      allow_any_instance_of(AccountBooksController).to receive(:authenticated_user)
      WebMock.enable!
      WebMock.stub_request(:post, 'https://api.zaim.net/v2/home/money/payment').to_return(
        status: 200,
        headers: { 'Content-Type'=> 'application/json' })
    end

    it "should respond success message with valid account_data" do
      account_data_attributes = FactoryBot.attributes_for(:account_data)
      post account_books_path, params:{account_data: account_data_attributes}
      expect(flash[:success]).to include("create account record is successful.")
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_books_path
    end

    it "should respond alert message with invalid account_data" do
      invalid_data_attributes= FactoryBot.attributes_for(:account_data, category_id:"")
      post account_books_path, params:{ account_data: invalid_data_attributes }
      expect(flash[:alert]).to include("Input value is incorrect")
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_books_path
    end

  end

	describe "should be redirect to #index after delete account data" do
    before do
      allow_any_instance_of(AccountBooksController).to receive(:authenticated_user)
      WebMock.enable!
      WebMock.stub_request(:delete, 'https://api.zaim.net/v2/home/money/payment/1').to_return(
        status: 200,
        headers: { 'Content-Type'=> 'application/json' })
    end
    it "should respond success message after delete account record" do
      delete account_book_path(1)
      expect(response).to have_http_status(302)
      expect(flash[:success]).to include("destroy account record is successful")
      expect(response).to redirect_to account_books_path
    end
  end

end
