require 'rails_helper'

RSpec.describe "TopPages", type: :request do

  describe "GET /top_pages" do
    it "responds successfully" do
      get root_path
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

end
