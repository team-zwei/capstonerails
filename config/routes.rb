Capstone::Application.routes.draw do
  ActiveAdmin.routes(self)

  get "account" => "users#show"

  get "admin/logout" => "sessions#destroy", as: "admin/logout"
  devise_for :admin_users, ActiveAdmin::Devise.config

  post "auctions/bids" => "bids#create"
  
  get "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  get "signup" => "users#new", as: "signup"
  get "help" => "help#index", as: "help"

  root to: "home#index"

  resources :users do
    resources :payment_methods
  end
  resources :auctions do
    resources :bids
    resource :payment
  end

  resources :bids
  resources :sessions
  resources :password_resets  
end
