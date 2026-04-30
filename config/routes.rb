Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "health", to: "health#show"

      post "signup", to: "auth#signup"
      post "login", to: "auth#login"

      get "me", to: "users#me"
    end
  end
end