Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :users do
      post 'signup'
      post 'login'
    end

    resources :posts, only: [:index, :create, :update, :destroy] do
      resources :reactions, only: [:index, :create, :update, :destroy]
      resources :comments, only: [:index]
    end

    resources :friendships, only: [:index] do
      post 'send_friend_request', on: :collection
      member do
        post 'accept_friend_request'
        post 'reject_friend_request'
      end
    end
  end
end
