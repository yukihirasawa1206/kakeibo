require 'rails_helper'

RSpec.describe "OauthAuthenticates", type: :request do
  describe "GET /login" do
    it "should return a 200 response" do
      get login_path
      expect(response).to have_http_status(200)
    end
  end
end
