Rails.application.routes.draw do
  devise_for :users
  resources :books, param: :asin, only: [:index] do
    resource :review
  end
  resources :reviews, only: [:index]
  get 'home/index'
  root 'home#index'
end
