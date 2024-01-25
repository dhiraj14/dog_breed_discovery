require 'rails_helper'

RSpec.describe "DogsController", type: :request do
  describe "GET /index" do
    it 'renders the root page' do
      get "/"
      expect(response).to have_http_status(:ok)
    end
  end
end
