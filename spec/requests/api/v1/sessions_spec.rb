require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do

  let!(:user) { create(:user) }

  describe "create request" do
    it "returns a success response and expected body" do
      post api_sessions_path, params: { email: user.email, password: user.password }
      expect(response).to be_successful
      expect(response.body).to eq({ data: build(:user_serializer, user: user) }.to_json)
    end

    it "rise an error if email and password are not valid" do
      post api_sessions_path, params: { email: user.email, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
