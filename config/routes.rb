Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "health", to: "health#show"

      post "signup", to: "auth#signup"
      post "login", to: "auth#login"

      get "me", to: "users#me"
      resources :portfolios, only: [:create, :index]
      resources :portfolios do
        resources :holdings, only: [:index, :create]
      end
      resources :portfolios do
        resources :holdings, only: [:index]
        resources :transactions, only: [:create]
      end
    end
  end
end