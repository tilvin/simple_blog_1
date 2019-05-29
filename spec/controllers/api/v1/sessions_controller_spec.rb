require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do

  let!(:user) { create(:user) }

  describe "POST #create" do
    it 'give user info if email and password are valid' do
      post :create, params: { email: user.email, password: user.password }
      expect(response).to be_successful
    end

    it 'rise an error if email and password are not valid' do
      post :create, params: { email: user.email, password: 'wrong_password' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
