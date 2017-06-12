Rails.application.routes.draw do
  root "static_pages#home"
  get "home"            => "static_pages#home"
  get "help"            => "static_pages#help"
  get "about"           => "static_pages#about"
  get "signup"         => "users#new"
  post "signup"        => "users#create"
  get "login"           => "sessions#new"
  post "login"          => "sessions#create"
  delete "logout"       => "sessions#destroy"

  resources :users do
    member do
      get :followers, :following
    end
  end
  resources :account_actications, only: :edit
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
