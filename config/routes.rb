Rails.application.routes.draw do
  devise_for :users
  resources :items
  get 'books/search'
  resources :books, param: :asin, only: [:show]
  get 'home/index'
  root 'home#index'
end
