require "rails_helper"

RSpec.describe "Posts management", type: :request do

  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:my_post) { create(:post, user: user, description: "Post abount my dog") }
  let!(:my_another_post) { create(:post, user: user, description: "Post abount my cat") }
  let!(:another_post) { create(:post, description: "Another post") }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { attributes_for(:post, title: '') }

  describe 'index page for user' do

    before { sign_in user }

    it "return a success response and user posts" do
      get posts_path
      expect(response).to be_successful
      expect(response.body).to include(my_post.title)
      expect(response.body).to include(my_another_post.title)
      expect(response.body).to_not include(another_post.title)
    end

    it "with search params return a success response and user mathed posts" do
      get posts_path(q: { description_cont: "my dog" })
      expect(response).to be_successful
      expect(response.body).to include(my_post.title)
      expect(response.body).to_not include(my_another_post.title)
      expect(response.body).to_not include(another_post.title)
    end
  end

  describe 'index page for another user' do

    before { sign_in another_user }

    it "return a success response without posts" do
      get posts_path
      expect(response).to be_successful
      expect(response.body).to include('Sorry, no posts yet.')
    end
  end

  describe 'show page for user' do

    before { sign_in user }

    it "return success response and post" do
      get post_path(my_post)
      expect(response).to be_successful
      expect(response.body).to include(my_post.title)
    end
  end

  describe 'show page for another user' do
    before { sign_in another_user }

    it "return 404", :realistic_error_responses do
      get post_path(my_post)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "update post when user in an author" do

    before { sign_in user }

    it "return success response and redirect" do
      get edit_post_path(my_post)
      expect(response).to be_successful

      patch post_path(my_post), params: { post: valid_attributes }

      expect(response).to redirect_to(my_post)
      follow_redirect!
      expect(response.body).to include(valid_attributes[:title])
    end

    it "returns a success response and render edit if params invalid" do
      patch post_path(my_post), params: { post: invalid_attributes }
      expect(response).to be_successful
      expect(response.body).to include('Update the post')
    end
  end

  describe 'update post when user is not an author' do

    before { sign_in another_user }

    it "return 404", :realistic_error_responses do
      get edit_post_path(my_post)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "create post" do

    before { sign_in user }

    it "return success response and redirect" do
      get new_post_path
      expect(response).to be_successful
      expect(response.body).to include('Create a new post')

      post posts_path, params: { post: valid_attributes }

      expect(response).to redirect_to(Post.last)
      follow_redirect!
      expect(response.body).to include(valid_attributes[:title])
    end

    it "returns a success response and display the 'new' template if params invalid" do
      post posts_path, params: { post: invalid_attributes }
      expect(response).to be_successful
      expect(response.body).to include('Create a new post')
    end
  end


  describe "delete post when user is an author" do

    before { sign_in user }

    it "redirects to list posts" do
      delete post_path(my_post)
      expect(response).to redirect_to(posts_path)
      expect(response.body).to_not include(my_post.title)
    end
  end

  describe 'delete post when user is not an author' do

    before { sign_in another_user }

    it "return 404", :realistic_error_responses do
      delete post_path(my_post)
      expect(response).to have_http_status(:not_found)
    end
  end
end
