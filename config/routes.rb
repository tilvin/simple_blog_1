Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users

  resources :posts

  namespace :api, path: 'api/v1', module: 'api/v1' do
    resources :sessions, only: [:create]
    resources :posts, only: [:index, :show]
  end
end
