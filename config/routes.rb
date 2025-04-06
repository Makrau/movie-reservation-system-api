Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  defaults format: :json do
    # Public routes that don't require authentication
    namespace :public do
      resources :movies, only: [:index, :show]
      resources :genres, only: [:index, :show]
    end

    # Admin routes that require admin privileges
    namespace :admin do
      post '/auth/login', to: 'authentication#login'
      resources :movies
      resources :genres
      resources :movie_rooms
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
