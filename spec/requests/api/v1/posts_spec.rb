require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :request do
  let!(:user) { create(:user) }
  let!(:my_post) { create(:post, user: user) }
  let!(:another_post) { create(:post) }
  let(:authorization) { { authorization: JwtProcessor.encode(user.email) } }

  describe "index request" do
    it "returns a success response and expected body" do
      get api_posts_path, headers: authorization
      expect(response).to be_successful
      expect(response.body).to eq({
        data: [
          build(:post_serializer, post: my_post),
          build(:post_serializer, post: another_post)
        ]
      }.to_json)
    end
  end

  describe "show request" do
    it "returns a success response and expected body" do
      get api_post_path(my_post), headers: authorization
      expect(response).to be_successful
      expect(response.body).to eq({ data: build(:post_serializer, post: my_post) }.to_json)
    end
  end
end
