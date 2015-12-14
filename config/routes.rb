Rails.application.routes.draw do
  devise_for :users
  resources :items
  get 'books/search'
  get 'home/index'
  root 'home#index'
end
