Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
  }
  root to: "home#index"
  resources :users, only: :show
  resources :driving_requests, only: [:new, :create]
end
