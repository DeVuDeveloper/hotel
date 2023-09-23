require 'rails_helper'

RSpec.describe "NewsletterSubscribers", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/newsletter_subscribers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/newsletter_subscribers/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/newsletter_subscribers/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
