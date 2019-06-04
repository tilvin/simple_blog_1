Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts

  namespace :api, path: 'api/v1', module: 'api/v1' do
    resources :sessions, only: [:create]
    resources :posts, only: [:index, :show]
  end

  get "/rails/active_storage/blobs/:signed_id/*filename", to: 'active_storage/blobs_representation#show'
  get "/rails/active_storage/disk/:encoded_key/*filename", to: 'active_storage/disk_representation#show'

  root 'posts#index'
end
