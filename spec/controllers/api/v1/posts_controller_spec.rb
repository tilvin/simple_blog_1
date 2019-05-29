require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:post_object) { create(:post, user: user) }
  let!(:another_post) { create(:post) }

  before do
    request.headers.merge!(authorization: JwtProcessor.encode(user.email))
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: post_object.id }
      expect(response).to be_successful
    end

    it "render 404 if user is not an author" do
      expect {
        get :show, params: { id: another_post.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
