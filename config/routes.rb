Rails.application.routes.draw do
  root "static_pages#home"
  get "home"       => "static_pages#home"
  get "help"       => "static_pages#help"
  get "about"      => "static_pages#about"
  get "signup"     => "users#new"
  get "login"      => "sessions#new"
  post "login"     => "sessions#create"
  delete "logout"  => "sessions#destroy"

  resources :users
  resources :account_actications, only: :edit
end
