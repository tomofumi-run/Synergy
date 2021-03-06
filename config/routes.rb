Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions: 'admin/sessions',
  }
  namespace :admin do
    resources :users, only: %i(index show edit update destroy) do
      collection do
        get 'search'
      end
    end
    resources :posts, only: %i(index show destroy) do
      collection do
        get 'search'
      end
    end
    resources :genres, only: %i(index create edit update destroy)
    get 'chart' => 'charts#post_chart'
  end

  devise_for :users, controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords',
  }
  
  devise_scope :user do
    post 'guest/sign_in', to: 'guests/sessions#new_guest'
  end

  get 'about' => 'public/homes#about'
  root 'public/homes#top'

  scope module: :public do
    resources :users, only: %i(index show edit update) do
      member do
        get 'likes'
        get 'quit'
        patch 'out'
      end

      resource :relationships, only: %i(create destroy)
      get 'followings', to: 'relationships#followings', as: 'followings'
      get 'followers', to: 'relationships#followers', as: 'followers'
      resources :notifications, only: :index do
        collection do
          delete '/' => 'notifications#destroy_all'
        end
      end
      get 'search'
    end

    resources :posts do
      resource :likes, only: %i(create destroy)
      resources :comments, only: %i(create destroy)
      collection do
        get 'search'
        get 'search/genre' => 'posts#search_genre'
      end
    end

    get 'chat/:user_id', to: 'chats#show', as: 'chat'
    resources :chats, only: %i(index create)
    resources :user_rooms, only: [:destroy]
    resources :contacts, only: %i(new create) do
      collection do
        get 'thanx'
      end
    end
  end
end
