Capstone::Application.routes.draw do
  ActiveAdmin.routes(self)

  match "account" => "users#show"

  get "admin/logout" => "sessions#destroy", as: "admin/logout"
  devise_for :admin_users, ActiveAdmin::Devise.config

  post "auctions/bids" => "bids#create"
  
  get "logout" => "sessions#destroy", as: "logout"
  get "login" => "sessions#new", as: "login"
  get "signup" => "users#new", as: "signup"
  get "help" => "help#index", as: "help"

  root to: "home#index"

  resources :users
  resources :auctions do
    resources :bids
  end
  resources :sessions
  resources :password_resets
  resources :payments
  
end
