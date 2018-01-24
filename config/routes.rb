Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount ActionCable.server => "/cable"
  get 'errors/error_404'

  root to: "home#index"

  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags
  devise_for :users
  resources :tweets do
    resources :comments
    member do
      post :retweet
      get "like", "unlike"
    end
  end

  resources :activities
  get 'notifications', to: 'activities#index', as: :notifications
  # get ':username', to: 'users#show', as: :profile

  resources :users do
    member do
      get :following, :followers
      get 'photos', to: 'users#photos', as: :photos
      patch :verified
    end
  end

  resources :relationships,       only: [:create, :destroy]
  
  resources :chatrooms do
    resource :chatroom_users
    resources :messages
  end

  get 'chats', to: 'chatrooms#index', as: :chats
  resources :direct_messages
  get '*path', to: 'errors#error_404', via: :all
  # get 'mentions', to: 'users#mentions'
  get 'share/users', as: :mentionables
end
