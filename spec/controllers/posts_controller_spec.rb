require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let!(:user) { create(:user) }
  let!(:post_object) { create(:post, user: user) }
  let!(:another_post) { create(:post) }
  let(:valid_attributes) { attributes_for(:post) }
  let(:invalid_attributes) { attributes_for(:post, title: '') }

  before do
    sign_in user
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

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: post_object.id }
      expect(response).to be_successful
    end

    it "render 404 if user is not an author" do
      expect {
        get :edit, params: { id: another_post.id }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Post" do
        expect {
          post :create, params: { post: valid_attributes }
        }.to change(Post, :count).by(1)
      end

      it "redirects to the created post" do
        post :create, params: { post: valid_attributes }
        expect(response).to redirect_to(post_path(Post.last))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { post: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { title: 'New Title' } }

      it "updates the requested post" do
        put :update, params: { id: post_object.id, post: new_attributes }
        expect(post_object.reload.title).to eq('New Title')
      end

      it "redirects to the post" do
        put :update, params: { id: post_object.to_param, post: valid_attributes }
        expect(response).to redirect_to(post_path(post_object))
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update, params: { id: post_object.to_param, post: invalid_attributes }
        expect(response).to be_successful
      end
    end

    it "render 404 if user is not an author" do
      expect {
        put :update, params: { id: another_post.id, post: valid_attributes }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested post" do
      expect {
        delete :destroy, params: { id: post_object.to_param }
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, params: { id: post_object.to_param }
      expect(response).to redirect_to(posts_path)
    end

    it "render 404 if user is not an author" do
      expect {
        delete :destroy, params: { id: another_post.to_param }
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
