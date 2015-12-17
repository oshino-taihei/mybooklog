Rails.application.routes.draw do
  devise_for :users
  get 'books/search'
  resources :books, param: :asin, only: [:show] do
    resource :review
  end
  resources :reviews, only: [:index]
  get 'home/index'
  root 'home#index'
end
