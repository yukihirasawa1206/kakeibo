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

      it "responds successfully" do
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

    it "responds successfully" do
      account_data_attributes = FactoryBot.attributes_for(:account_data)
      post account_books_path, params:{account_data: account_data_attributes}
      expect(response).to have_http_status(302)
      expect(response).to redirect_to account_books_path
    end

  end

end
